# frozen_string_literal: true

module AhlScraper
  class PlayoffBracketDataFetcher
    def initialize(season_id)
      @season_id = season_id
    end

    def call
      JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true).dig(:SiteKit, :Brackets)
    end

    private

    def url
      @url ||= "https://lscluster.hockeytech.com/feed/index.php?feed=modulekit&view=brackets&fmt=json&season_id=#{@season_id}&key=ccb91f29d6744675&client_code=ahl&site_id=3&lang=en&league_id=&callback=json" # rubocop:disable Layout/LineLength
    end
  end
end
