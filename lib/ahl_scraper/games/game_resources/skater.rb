# frozen_string_literal: true

module AhlScraper
  module Games
    class Skater < GameResource
      def id
        @id ||= raw_data[:info][:id]
      end

      def team_id
        @team_id ||= opts[:team_id]
      end

      def team_abbreviation
        @team_abbreviation ||= opts[:team_abbreviation]
      end

      def info
        @info ||= @raw_data[:info]
      end

      def stats
        @stats ||= @raw_data[:stats]
      end

      def starting
        @starting ||= raw_data[:starting] == 1
      end

      def captaincy
        @captaincy ||= %w[A C].include?(raw_data[:status]) ? raw_data[:status] : nil
      end

      def on_home_team
        @on_home_team ||= opts[:on_home_team]
      end
    end
  end
end
