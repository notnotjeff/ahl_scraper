# frozen_string_literal: true

require "ahl_scraper/fetchers/player_games/data_fetcher"

module AhlScraper
  module PlayerGames
    @season_games = {}

    class << self
      def list(player_id, season_id)
        @season_games["#{player_id}-#{season_id}"] ||= DataFetcher.new(player_id, season_id).call&.map do |player_data|
          player_data[:position] == "G" ? GoalieGameListItem.new(player_data) : SkaterGameListItem.new(player_data)
        end

        @season_games["#{player_id}-#{season_id}"]
      end
    end
  end
end
