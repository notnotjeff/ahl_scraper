# frozen_string_literal: true

require "ahl_scraper/seasons/format/teams"

require "ahl_scraper/seasons/season_resource"
require "ahl_scraper/seasons/season_object"

module AhlScraper
  module Seasons
    @@season_data = nil

    class << self
      def list
        @@season_data ||= Fetch::SeasonData.new.call
      end

      def retrieve(season_ids)
        is_array = season_ids.class == Array
        season_ids = Array(season_ids).map(&:to_i)

        @@season_data ||= Fetch::SeasonData.new.call
        filtered_season_data = @@season_data.select { |s| season_ids.include? s[:id].to_i }

        season_objects = filtered_season_data.map do |season|
          SeasonObject.new(season)
        end

        is_array ? season_objects : season_objects[0]
      end

      def retrieve_all
        @@season_data ||= Fetch::SeasonData.new.call
        @@season_data.map do |season|
          SeasonObject.new(season)
        end
      end
    end
  end
end
