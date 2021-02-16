# frozen_string_literal: true

module AhlScraper
  module Games
    class Goalie < GameResource
      def id
        @id ||= @raw_data[:info][:id]
      end

      def first_name
        @first_name ||= @raw_data[:info][:firstName]
      end

      def last_name
        @last_name ||= @raw_data[:info][:lastName]
      end

      def number
        @number ||= @raw_data[:info][:jerseyNumber]
      end

      def team_id
        @team_id ||= @opts[:team_id]
      end

      def home_team
        @home_team ||= @opts[:home_team]
      end

      def position
        @position ||= @raw_data[:info][:position]
      end

      def birthdate
        @birthdate ||= @raw_data[:info][:birthDate]
      end

      def stats
        @stats ||= {
          goals: @raw_data[:stats][:goals],
          assists: @raw_data[:stats][:assists],
          points: @raw_data[:stats][:points],
          penalty_minutes: @raw_data[:stats][:penaltyMinute],
          toi: @raw_data[:stats][:timeOnIce],
          toi_in_seconds: set_time_on_ice_in_seconds,
          shots_against: @raw_data[:stats][:shotsAgainst],
          goals_against: @raw_data[:stats][:goalsAgainst],
          saves: @raw_data[:stats][:saves],
          save_percent: @raw_data[:stats][:shotsAgainst].positive? ? set_save_percent : nil,
        }
      end

      def starting
        @starting ||= @raw_data[:starting]
      end

      def status
        @status ||= @raw_data[:status]
      end

      def captaincy
        nil
      end

      private

      def set_save_percent
        BigDecimal(@raw_data[:stats][:shotsAgainst] - @raw_data[:stats][:goalsAgainst]) / @raw_data[:stats][:shotsAgainst] * 100
      end

      def set_time_on_ice_in_seconds
        @raw_data[:stats][:timeOnIce].nil? ? nil : Helpers::IceTime.new(@raw_data[:stats][:timeOnIce]).to_sec
      end
    end
  end
end
