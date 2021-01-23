# frozen_string_literal: true

module AhlScraper
  module Seasons
    module Fetch
      module StartAndEndDays
        module_function

        def fetch(season_id, start_month, end_month)
          [start_day(season_id, start_month), end_day(season_id, end_month)]
        end

        def start_day(season_id, start_month)
          start_date_url = "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=schedule&team=-1&season=#{season_id}&month=#{start_month}&location=homeaway&key=50c2cd9b5e18e390&client_code=ahl&site_id=1&callback=json"
          JSON.parse(Nokogiri::HTML(URI.parse(start_date_url).open).text[5..-2], symbolize_names: true)
            &.first
            &.dig(:sections)
            &.first
            &.dig(:data)
            &.first
            &.dig(:row, :date_with_day)
        end

        def end_day(season_id, end_month)
          end_date_url = "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=schedule&team=-1&season=#{season_id}&month=#{end_month}&location=homeaway&key=50c2cd9b5e18e390&client_code=ahl&site_id=1&league_id=4&division_id=-1&lang=en&callback=json"
          JSON.parse(Nokogiri::HTML(URI.parse(end_date_url).open).text[5..-2], symbolize_names: true)
            &.first
            &.dig(:sections)
            &.first
            &.dig(:data)
            &.last
            &.dig(:row, :date_with_day)
        end
      end
    end
  end
end
