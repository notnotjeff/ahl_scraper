# frozen_string_literal: true

require "ahl_scraper/teams/team_object"

module AhlScraper
  module Teams
    class << self
      def list(season_id)
        Fetch::TeamData.new(season_id).call&.map { |team| TeamObject.new(team, season_id) }
      end
    end
  end
end
