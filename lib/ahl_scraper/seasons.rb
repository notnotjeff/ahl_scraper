# frozen_string_literal: true

require "ahl_scraper/services/seasons/teams_service"

require "ahl_scraper/resources/seasons/team"

module AhlScraper
  module Seasons
    @season_data = nil

    class << self
      def list
        @season_data ||= SeasonDataFetcher.new.call&.map { |season_data| SeasonListItem.new(season_data) }
        @season_data
      end

      def retrieve(season_id)
        @season_data ||= SeasonDataFetcher.new.call
        season = @season_data.find { |s| season_id.to_i == s.id }
        Season.new(season)
      end

      def retrieve_all
        @season_data ||= SeasonDataFetcher.new.call
        @season_data.map do |season|
          Season.new(season)
        end
      end
    end
  end
end
