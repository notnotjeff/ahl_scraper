# frozen_string_literal: true

module AhlScraper
  module Fetch
    class SeasonStartDay
      def initialize(season_id, start_month)
        @season_id = season_id
        @start_month = start_month
      end

      def call
        JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)
          &.first
          &.dig(:sections)
          &.first
          &.dig(:data)
          &.first
          &.dig(:row, :date_with_day)
      end

      private

      def url
        "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=schedule&team=-1&season=#{@season_id}&month=#{@start_month}&location=homeaway&key=50c2cd9b5e18e390&client_code=ahl&site_id=1&callback=json"
      end
    end
  end
end
