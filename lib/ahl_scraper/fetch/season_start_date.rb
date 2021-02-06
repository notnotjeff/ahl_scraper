# frozen_string_literal: true

module AhlScraper
  module Fetch
    class SeasonStartDate
      def initialize(season_id, season_type)
        @season_id = season_id
        @season_type = season_type
      end

      def call
        return if %i[all_star_game exhibition].include? @season_type

        return Helpers::SeasonDates::DATE_EXCEPTIONS[@season_id][:start_date] if Helpers::SeasonDates::DATE_EXCEPTIONS.keys.include? @season_id

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
