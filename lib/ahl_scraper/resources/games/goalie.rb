# frozen_string_literal: true

module AhlScraper
  module Games
    class Goalie < Resource
      def id
        @id ||= @raw_data[:info][:id]
      end

      def first_name
        @first_name ||= @raw_data[:info][:firstName]
      end

      def last_name
        @last_name ||= @raw_data[:info][:lastName]
      end

      def jersey_number
        @jersey_number ||= @raw_data[:info][:jerseyNumber]
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
        @birthdate ||= valid_birthdate? ? @raw_data[:info][:birthDate] : nil
      end

      def current_age
        @current_age ||= valid_birthdate? ? BirthdateHelper.new(birthdate).age_on_date(@opts[:game_date]) : nil
      end

      def stats
        @stats ||= {
          goals: @raw_data[:stats][:goals],
          assists: @raw_data[:stats][:assists],
          points: @raw_data[:stats][:points],
          penalty_minutes: @raw_data[:stats][:penaltyMinutes],
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

      def shootout
        @shootout ||= {
          attempts_against: shootout_data.size,
          goals_against: shootout_data.filter { |attempt| attempt[:isGoal] == true }.size,
        }
      end

      def penalty_shots
        @penalty_shots ||= {
          attempts_against: penalty_shot_data.size,
          goals_against: penalty_shot_data.filter { |attempt| attempt[:isGoal] == true }.size,
        }
      end

      private

      def set_save_percent
        BigDecimal(@raw_data[:stats][:shotsAgainst] - @raw_data[:stats][:goalsAgainst]) / @raw_data[:stats][:shotsAgainst] * 100
      end

      def set_time_on_ice_in_seconds
        @raw_data[:stats][:timeOnIce].nil? ? nil : IceTimeHelper.new(@raw_data[:stats][:timeOnIce]).to_sec
      end

      def shootout_data
        @shootout_data ||= (@opts[:shootout_data] || []).filter { |so| so[:goalie][:id] == id }
      end

      def penalty_shot_data
        @penalty_shot_data ||= (@opts[:penalty_shot_data] || []).filter { |so| so[:goalie][:id] == id }
      end

      def valid_birthdate?
        @valid_birthdate ||= !@raw_data.dig(:info, :birthDate).empty? && @raw_data.dig(:info, :birthDate) != "0000-00-00"
      end
    end
  end
end
