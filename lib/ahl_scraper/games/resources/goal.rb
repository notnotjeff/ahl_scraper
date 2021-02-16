# frozen_string_literal: true

module AhlScraper
  module Games
    class Goal < GameResource
      def id
        @id ||= @raw_data[:game_goal_id]
      end

      def number
        @number ||= @opts[:number]
      end

      def period
        @period ||= @raw_data[:period][:id].to_i
      end

      def time
        @time ||= @raw_data[:time]
      end

      def period_time_in_seconds
        @period_time_in_seconds ||= period_time.to_sec
      end

      def game_time_elapsed
        @game_time_elapsed ||= period_time.to_elapsed
      end

      def scorer_goal_number
        @scorer_goal_number ||= @raw_data[:scorerGoalNumber]
      end

      def scored_by
        @scored_by ||= {
          id: @raw_data[:scoredBy][:id],
          first_name: @raw_data[:scoredBy][:firstName],
          last_name: @raw_data[:scoredBy][:lastName],
          number: @raw_data[:scoredBy][:jerseyNumber],
          position: @raw_data[:scoredBy][:position],
        }
      end

      def assists
        @assists ||= @raw_data[:assists].map do |assist|
          {
            id: assist[:id],
            first_name: assist[:firstName],
            last_name: assist[:lastName],
            number: assist[:jerseyNumber],
            position: assist[:position],
          }
        end
      end

      def assist_numbers
        @assist_numbers ||= @raw_data[:assistNumbers]
      end

      def scoring_team
        @scoring_team ||= @raw_data[:team]
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

      def empty_net_for?
        @empty_net_for ||= set_empty_net_for
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

      def situation
        @situation ||=
          if @raw_data[:properties][:isPowerPlay] == "1"
            "PP"
          elsif @raw_data[:properties][:isShortHanded] == "1"
            "SH"
          elsif @raw_data[:properties][:isEmptyNet] == "1"
            "EN"
          elsif empty_net_for? == true
            "ENF"
          elsif @raw_data[:properties][:isPenaltyShot] == "1"
            "PS"
          else
            "EV"
          end
      end

      def description
        @description ||=
          if assists.nil? || assists.empty?
            goalscorer_name
          elsif assists.length == 1
            "#{goalscorer_name} (#{a1_name})"
          else
            "#{goalscorer_name} (#{a1_name}, #{a2_name})"
          end
      end

      def special_teams?
        @special_teams ||= short_handed? || power_play?
      end

      private

      def set_empty_net_for
        return true if plus_players.length > minus_players.length && !special_teams? && !penalty_shot?

        return true if plus_players.length == minus_players.length && short_handed?

        return true if plus_players.length == 6

        false
      end

      def goalscorer_name
        @goalscorer_name ||= "#{scored_by[:first_name]} #{scored_by[:last_name]}"
      end

      def a1_name
        @a1_name ||= "#{assists.dig(0, :first_name)} #{assists.dig(0, :last_name)}"
      end

      def a2_name
        @a2_name ||= "#{assists.dig(1, :first_name)} #{assists.dig(1, :last_name)}"
      end

      def period_time
        @period_time ||= Helpers::PeriodTime.new(time, period)
      end
    end
  end
end
