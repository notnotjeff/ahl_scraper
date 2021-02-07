# frozen_string_literal: true

require "ahl_scraper/players/player_object"

module AhlScraper
  module Players
    class << self
      def retrieve(team_id, season_id)
        Fetch::TeamRosterData.new(team_id, season_id).call&.map { |player| PlayerObject.new(player) }
      end
    end
  end
end
