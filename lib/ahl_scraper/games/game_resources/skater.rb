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

      def first_name
        @first_name ||= @raw_data[:info][:firstName]
      end

      def last_name
        @last_name ||= raw_data[:info][:lastName]
      end

      def number
        @number ||= raw_data[:info][:jerseyNumber]
      end

      def position
        @position ||= raw_data[:info][:position]
      end

      def birthdate
        @birthdate ||= raw_data[:info][:birthDate]
      end

      def starting
        @starting ||= raw_data[:starting] == 1
      end

      def captaincy
        @captaincy ||= %w[A C].include?(raw_data[:status]) ? raw_data[:status] : nil
      end

      def goals
        @goals ||= raw_data[:stats][:goals]
      end

      def assists
        @assists ||= raw_data[:stats][:assists]
      end

      def points
        @points = raw_data[:stats][:points]
      end

      def penalty_minutes
        @penalty_minutes ||= raw_data[:stats][:penaltyMinutes]
      end

      def plus_minus
        @plus_minus ||= raw_data[:stats][:plusMinus]
      end

      def faceoff_attempts
        @faceoff_attempts ||= raw_data[:stats][:faceoffAttempts]
      end

      def faceoff_wins
        @faceoff_wins ||= raw_data[:stats][:faceoffWins]
      end

      def shots
        @shots ||= raw_data[:stats][:shots]
      end

      def hits
        @hits ||= raw_data[:stats][:hits]
      end

      def on_home_team
        @on_home_team ||= opts[:on_home_team]
      end
    end
  end
end
