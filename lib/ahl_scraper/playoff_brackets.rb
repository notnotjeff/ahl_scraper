# frozen_string_literal: true

require "ahl_scraper/tags/season_tag"

require "ahl_scraper/playoff_brackets/resources/game"
require "ahl_scraper/playoff_brackets/resources/round"
require "ahl_scraper/playoff_brackets/resources/series"
require "ahl_scraper/playoff_brackets/resources/team"

require "ahl_scraper/playoff_brackets/playoff_bracket_object"

module AhlScraper
  module PlayoffBrackets
    class << self
      def list
        Fetch::SeasonData.new
          .call
          &.map { |season_data| SeasonTag.new(season_data) }
          &.filter { |season| season.season_type == :playoffs }
      end

      def retrieve(season_id)
        bracket_data = Fetch::PlayoffBracketData.new(season_id).call
        PlayoffBracketObject.new(bracket_data)
      end
    end
  end
end
