# frozen_string_literal: true

module AhlScraper
  class SeasonTypeFetcher
    def initialize(season_id)
      @season_id = season_id
    end

    def call
      season = JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)
        .dig(:seasons)
        &.find { |s| s[:id].to_i == @season_id.to_i }
      return nil unless season

      case season[:name]
      when /Regular/
        :regular
      when /All-Star/
        :all_star
      when /Playoffs/
        :playoffs
      when /Exhibition/
        :exhibition
      end
    end

    private

    def url
      "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=bootstrap&season=latest&pageName=schedule&key=50c2cd9b5e18e390&client_code=ahl&site_id=1&league_id=&league_code=&lang=en&callback=json"
    end
  end
end
