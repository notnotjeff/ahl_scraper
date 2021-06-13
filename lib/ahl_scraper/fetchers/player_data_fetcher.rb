# frozen_string_literal: true

module AhlScraper
  class PlayerDataFetcher
    def initialize(player_id)
      @player_id = player_id
    end

    def call
      JSON.parse(player_data_without_bio, symbolize_names: true)
    end

    private

    def url
      @url ||= "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=player&player_id=#{@player_id}&season_id=&site_id=3&key=ccb91f29d6744675&client_code=ahl&league_id=&lang=en&statsType=standard&callback=json" # rubocop:disable Layout/LineLength
    end

    def player_data_without_bio
      data = Nokogiri::HTML(URI.parse(url).open).text[5..-2]
      bio = data[/\"bio"\:(.*?)\,\"teamName/m, 1]
      data.gsub(bio, "\"\"")
    end
  end
end
