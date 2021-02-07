# frozen_string_literal: true

module AhlScraper
  module Fetch
    class SeasonGameIds
      def initialize(season_id)
        @season_id = season_id
      end

      def call
        games =
          JSON.parse(Nokogiri::HTML(URI.parse(url).open)
            .text[5..-2], symbolize_names: true)
            .dig(0, :sections, 0, :data)
            &.map { |g| g[:prop][:game_center][:gameLink].to_i }
      end

      private

      def url
        "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=schedule&team=-1&season=#{@season_id}&month=-1&location=homeaway&key=ccb91f29d6744675&client_code=ahl&site_id=3&league_id=4&division_id=-1&lang=en&callback=json"
      end
    end
  end
end
