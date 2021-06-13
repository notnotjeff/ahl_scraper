# frozen_string_literal: true

require "ahl_scraper/games/events"

require "ahl_scraper/services/games/create_skaters_service"
require "ahl_scraper/services/games/on_ice_statlines_service"
require "ahl_scraper/services/games/penalty_shots_service"
require "ahl_scraper/services/games/penalty_shot_statlines_service"
require "ahl_scraper/services/games/penalty_statlines_service"
require "ahl_scraper/services/games/scoring_statlines_service"
require "ahl_scraper/services/games/shootout_statlines_service"
require "ahl_scraper/services/games/team_on_ice_goals_service"
require "ahl_scraper/services/games/time_splits_service"

require "ahl_scraper/resources/games/coach"
require "ahl_scraper/resources/games/goal"
require "ahl_scraper/resources/games/goalie"
require "ahl_scraper/resources/games/info"
require "ahl_scraper/resources/games/on_ice_skater"
require "ahl_scraper/resources/games/overtime"
require "ahl_scraper/resources/games/penalty_shot"
require "ahl_scraper/resources/games/penalty"
require "ahl_scraper/resources/games/period"
require "ahl_scraper/resources/games/referee"
require "ahl_scraper/resources/games/shootout_attempt"
require "ahl_scraper/resources/games/skater"
require "ahl_scraper/resources/games/star"
require "ahl_scraper/resources/games/team"

require "ahl_scraper/resources/games/events/shot"

module AhlScraper
  module Games
    @season_games = {}

    class << self
      def retrieve(game_id, season_type = nil)
        Game.new(game_id, season_type: season_type)
      end

      def list(season_id)
        @season_games[season_id.to_s] ||= SeasonGameIdsFetcher.new(season_id).call&.map { |game_data| GameListItem.new(game_data) }
      end
    end
  end
end
