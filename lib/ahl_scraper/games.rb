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
      def retrieve(game_id)
        GameObject.new(game_id)
      end
    end
  end
end
