# frozen_string_literal: true

require "ahl_scraper/fetchers/scoreboards/data_fetcher"

require "ahl_scraper/resources/scoreboards/team"

module AhlScraper
  module Scoreboards
    class << self
      def list(start_date, end_date)
        DataFetcher.new(start_date: start_date, end_date: end_date).call&.map { |game| Scoreboard.new(game) }
      end
    end
  end
end
