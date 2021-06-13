# frozen_string_literal: true

require "ahl_scraper/tags/game_tag"

require "ahl_scraper/games/services/create_skaters_service"

require "ahl_scraper/games/format/on_ice_statlines"
require "ahl_scraper/games/format/penalty_shots"
require "ahl_scraper/games/format/penalty_shot_statlines"
require "ahl_scraper/games/format/penalty_statlines"
require "ahl_scraper/games/format/scoring_statlines"
require "ahl_scraper/games/format/shootout_statlines"
require "ahl_scraper/games/format/team_on_ice_goals"
require "ahl_scraper/games/format/time_splits"

require "ahl_scraper/games/game_resource"
require "ahl_scraper/games/event_object"
require "ahl_scraper/games/game_object"

module AhlScraper
  module Games
    @season_games = {}

    class << self
      def retrieve(game_id, season_type = nil)
        GameObject.new(game_id, season_type: season_type)
      end

      def list(season_id)
        @season_games[season_id.to_s] ||= Fetch::SeasonGameIds.new(season_id).call&.map { |game_data| GameTag.new(game_data) }
      end
    end
  end
end
