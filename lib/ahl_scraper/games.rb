# frozen_string_literal: true

require "ahl_scraper/games/format/merge_goal"
require "ahl_scraper/games/format/penalty_shots"
require "ahl_scraper/games/format/scoring_statlines"

require "ahl_scraper/games/game_resource"
require "ahl_scraper/games/event_object"
require "ahl_scraper/games/game_object"

module AhlScraper
  module Games
    class << self
      def retrieve(game_id, season_type = nil)
        GameObject.new(game_id, season_type: season_type)
      end
    end
  end
end
