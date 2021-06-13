# frozen_string_literal: true

module AhlScraper
  module Games
    class TeamOnIceGoalsService
      def initialize(team_id, goal_data)
        @team_id = team_id
        @goal_data = goal_data
      end

      def call
        @on_ice_statline = generate_on_ice_statline
        @goal_data.each do |goal|
          @team_id == goal[:team][:id] ? goal_for(goal) : goal_against(goal)
        end

        @on_ice_statline
      end

      private

      def generate_on_ice_statline
        {
          gf_as: 0,
          gf_ev: 0,
          gf_pp: 0,
          gf_sh: 0,
          gf_ex: 0,
          gf_en: 0,
          gf_ps: 0,
          gf_6v6: 0,
          gf_6v5: 0,
          gf_6v4: 0,
          gf_6v3: 0,
          gf_5v6: 0,
          gf_5v5: 0,
          gf_5v4: 0,
          gf_5v3: 0,
          gf_4v6: 0,
          gf_4v5: 0,
          gf_4v4: 0,
          gf_4v3: 0,
          gf_3v6: 0,
          gf_3v5: 0,
          gf_3v4: 0,
          gf_3v3: 0,
          ga_as: 0,
          ga_ev: 0,
          ga_pp: 0,
          ga_sh: 0,
          ga_ex: 0,
          ga_en: 0,
          ga_ps: 0,
          ga_6v6: 0,
          ga_6v5: 0,
          ga_6v4: 0,
          ga_6v3: 0,
          ga_5v6: 0,
          ga_5v5: 0,
          ga_5v4: 0,
          ga_5v3: 0,
          ga_4v6: 0,
          ga_4v5: 0,
          ga_4v4: 0,
          ga_4v3: 0,
          ga_3v6: 0,
          ga_3v5: 0,
          ga_3v4: 0,
          ga_3v3: 0,
        }
      end

      def goal_against(goal)
        @on_ice_statline[:ga_as] += 1
        if goal[:plus_players].length >= 3 && goal[:minus_players].length >= 3
          @on_ice_statline["ga_#{goal[:minus_players].length}v#{goal[:plus_players].length}".to_sym] += 1
        end

        if goal[:properties][:isPenaltyShot] == "1"
          @on_ice_statline["ga_ps".to_sym] += 1
          return
        end

        if goal[:properties][:isEmptyNet] == "1"
          @on_ice_statline[:ga_ex] += 1
          return
        end

        if goal[:plus_players].length == 6 ||
           (goal[:plus_players].length > goal[:minus_players].length && !goal_is_special_teams(goal)) ||
           (goal[:plus_players].length == goal[:minus_players].length && goal[:properties][:isShortHanded] == "1")

          @on_ice_statline[:ga_en] += 1
          return
        end

        if goal[:properties][:isPowerPlay] == "1"
          @on_ice_statline[:ga_sh] += 1
          return
        end

        if goal[:properties][:isShortHanded] == "1"
          @on_ice_statline[:ga_pp] += 1
          return
        end

        @on_ice_statline[:ga_ev] += 1
      end

      def goal_for(goal)
        @on_ice_statline[:gf_as] += 1
        if goal[:plus_players].length >= 3 && goal[:minus_players].length >= 3
          @on_ice_statline["gf_#{goal[:plus_players].length}v#{goal[:minus_players].length}".to_sym] += 1
        end

        if goal[:properties][:isPenaltyShot] == "1"
          @on_ice_statline[:gf_ps] += 1
          return
        end

        if goal[:properties][:isEmptyNet] == "1"
          @on_ice_statline[:gf_en] += 1
          return
        end

        if goal[:plus_players].length == 6 ||
           (goal[:plus_players].length > goal[:minus_players].length && !goal_is_special_teams(goal)) ||
           (goal[:plus_players].length == goal[:minus_players].length && goal[:properties][:isShortHanded] == "1")

          @on_ice_statline[:gf_ex] += 1
          return
        end

        if goal[:properties][:isPowerPlay] == "1"
          @on_ice_statline[:gf_pp] += 1
          return
        end

        if goal[:properties][:isShortHanded] == "1"
          @on_ice_statline[:gf_sh] += 1
          return
        end

        @on_ice_statline[:gf_ev] += 1
      end

      def goal_is_special_teams(goal)
        goal[:properties][:isPenaltyShot] == "1" || goal[:properties][:isPowerPlay] == "1" || goal[:properties][:isShortHanded] == "1"
      end
    end
  end
end
