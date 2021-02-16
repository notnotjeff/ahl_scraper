# frozen_string_literal: true

module AhlScraper
  module PlayoffBrackets
    class PlayoffBracketObject < Resource
      def initialize(bracket_data)
        @bracket_data = bracket_data
      end

      def teams
        @teams ||= @bracket_data[:teams].map { |_team_id, team_data| Team.new(team_data) }
      end

      def rounds
        @rounds ||= @bracket_data[:rounds].map { |round| Round.new(round) }
      end

      def logo_url
        @logo_url ||= @bracket_data[:logo]
      end
    end
  end
end
