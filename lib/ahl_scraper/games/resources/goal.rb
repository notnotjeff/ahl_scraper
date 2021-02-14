# frozen_string_literal: true

module AhlScraper
  module Games
    class Goal < GameResource
      def number
        @number ||= @opts[:number]
      end

      def period
        @period ||= @raw_data[:period][:id].to_i
      end

      def time
        @time ||= @raw_data[:time]
      end

      def time_in_seconds
        @time_in_seconds ||= @raw_data[:time]
      end

      def scorer_goal_number
        @scorer_goal_number ||= @raw_data[:scorerGoalNumber]
      end

      def scored_by
        @scored_by ||= @raw_data[:scoredBy]
      end

      def assists
        @assists ||= @raw_data[:assists]
      end

      def assist_numbers
        @assist_numbers ||= @raw_data[:assistNumbers]
      end

      def power_play?
        @power_play ||= @raw_data[:properties][:isPowerPlay] == "1"
      end

      def short_handed?
        @short_handed ||= @raw_data[:properties][:isShortHanded] == "1"
      end

      def empty_net?
        @empty_net ||= @raw_data[:properties][:isEmptyNet] == "1"
      end

      def penalty_shot?
        @penalty_shot ||= @raw_data[:properties][:isPenaltyShot] == "1"
      end

      def insurance_goal?
        @insurance_goal ||= @raw_data[:properties][:isInsuranceGoal] == "1"
      end

      def game_winner?
        @game_winner ||= @raw_data[:properties][:isGameWinningGoal] == "1"
      end

      def plus_players
        @plus_players ||= @raw_data[:plus_players].map { |player| OnIceSkater.new(player, { scoring_team: true }) }
      end

      def minus_players
        @minus_players ||= @raw_data[:minus_players].map { |player| OnIceSkater.new(player, { scoring_team: false }) }
      end
    end
  end
end
