# frozen_string_literal: true

require "ahl_scraper/resources/playoff_brackets/game"
require "ahl_scraper/resources/playoff_brackets/round"
require "ahl_scraper/resources/playoff_brackets/series"
require "ahl_scraper/resources/playoff_brackets/team"

module AhlScraper
  module PlayoffBrackets
    class << self
      def retrieve(season_id)
        bracket_data = PlayoffBracketDataFetcher.new(season_id).call
        PlayoffBracket.new(bracket_data)
      end
    end
  end
end
