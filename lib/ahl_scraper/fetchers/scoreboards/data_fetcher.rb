# frozen_string_literal: true

module AhlScraper
  module Scoreboards
    class DataFetcher
      def initialize(start_date:, end_date:)
        @start_date = start_date
        @end_date = end_date
      end

      def call
        JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)&.dig(:SiteKit, :Scorebar)&.filter do |game|
          game_date = Date.parse(game[:Date])
          game_date >= @start_date && game_date <= @end_date
        end
      end

      private

      def url
        "https://lscluster.hockeytech.com/feed/index.php?feed=modulekit&key=ccb91f29d6744675&client_code=ahl&view=scorebar&numberofdaysahead=#{days_ahead}&numberofdaysback=#{days_back}&fmt=json&site_id=3&lang=en&league_id=4&division_id=undefined&callback=json" # rubocop:disable Layout/LineLength
      end

      def days_back
        date_today > @start_date ? (date_today - @start_date).to_i : 0
      end

      def days_ahead
        date_today < @end_date ? (@end_date - date_today).to_i : 0
      end

      def date_today
        @date_today ||= Date.today
      end
    end
  end
end
