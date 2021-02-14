# frozen_string_literal: true

require "ahl_scraper/games/format/merge_goal"
require "ahl_scraper/games/format/penalty_shots"
require "ahl_scraper/games/format/scoring_statlines"
require "ahl_scraper/games/format/team_on_ice_goals"
require "ahl_scraper/games/format/time_splits"

require "ahl_scraper/games/game_resource"
require "ahl_scraper/games/event_object"
require "ahl_scraper/games/game_object"

module AhlScraper
  module Games
    class << self
      def retrieve(game_id, season_type = nil)
        GameObject.new(game_id, season_type: season_type)
      end

      def list(season_id)
        Fetch::SeasonGameIds.new(season_id).call
      end
    end
  end
end
