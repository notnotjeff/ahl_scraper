# frozen_string_literal: true

require "ahl_scraper/tags/season_tag"

require "ahl_scraper/seasons/format/teams"

require "ahl_scraper/seasons/season_resource"
require "ahl_scraper/seasons/season_object"

module AhlScraper
  module Seasons
    @season_data = nil

    class << self
      def list
        @season_data ||= Fetch::SeasonData.new.call&.map { |season_data| SeasonTag.new(season_data) }
        @season_data
      end

      def retrieve(season_id)
        @season_data ||= Fetch::SeasonData.new.call
        season = @season_data.find { |s| season_id.to_i == s.id }
        SeasonObject.new(season)
      end

      def retrieve_all
        @season_data ||= Fetch::SeasonData.new.call
        @season_data.map do |season|
          SeasonObject.new(season)
        end
      end
    end
  end
end
