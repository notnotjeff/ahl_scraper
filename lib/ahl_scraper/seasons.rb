# frozen_string_literal: true

# Objects
require "ahl_scraper/seasons/season_object"
require "ahl_scraper/seasons/team_object"

module AhlScraper
  module Seasons
    class << self
      def retrieve(season_ids)
        season_ids = Array(season_ids.map(&:to_i))
        season_data = Fetch::SeasonData.new.call.filter { |s| season_ids.include? s["id"].to_i }

        season_data.map do |season|
          SeasonObject.new(season)
        end
      end

      def list
        season_data = Fetch::SeasonData.new.call

        season_data.map do |season|
          SeasonObject.new(season)
        end
      end
    end
  end
end
