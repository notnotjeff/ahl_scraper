# frozen_string_literal: true

require "ahl_scraper/fetchers/team_games/data_fetcher"

module AhlScraper
  module TeamGames
    @season_games = {}

    class << self
      def list(team_id, season_id)
        @season_games["#{team_id}-#{season_id}"] ||= DataFetcher.new(team_id, season_id).call&.map { |team_data| TeamGameListItem.new(team_data, { team_id: team_id }) }

        @season_games["#{team_id}-#{season_id}"]
      end
    end
  end
end
