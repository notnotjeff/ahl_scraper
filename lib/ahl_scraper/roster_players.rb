# frozen_string_literal: true

module AhlScraper
  module RosterPlayers
    class << self
      def retrieve_all(team_id, season_id)
        TeamRosterDataFetcher.new(team_id, season_id).call&.map { |player| RosterPlayer.new(player, team_id, season_id) }
      end
    end
  end
end
