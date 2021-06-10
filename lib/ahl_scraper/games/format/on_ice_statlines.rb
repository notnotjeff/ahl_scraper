# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      class OnIceStatlines
        def initialize(goal_data, team_id, skater_ids)
          @goal_data = goal_data
          @team_id = team_id
          @skater_ids = skater_ids
        end

        def call
          @goal_data.each do |goal|
            next if goal[:properties][:isPenaltyShot] == "1"

            goal_status = goal[:team][:id] == @team_id ? "gf" : "ga"
            on_scoring_team = goal[:team][:id] == @team_id
            plus_player_ids = goal[:plus_players].map { |pl| pl[:id].to_s }
            minus_player_ids = goal[:minus_players].map { |pl| pl[:id].to_s }
            skater_ids = on_scoring_team ? plus_player_ids : minus_player_ids
            opposing_skater_ids = on_scoring_team ? minus_player_ids : plus_player_ids
            goal_situation = find_goal_situation(goal, on_scoring_team)
            goal_player_counts = on_scoring_team ? "#{skater_ids.length}v#{opposing_skater_ids.length}" : "#{opposing_skater_ids.length}v#{skater_ids.length}"

            skater_ids.map(&:to_s).each do |skater_id|
              on_ice_statlines[skater_id] ||= blank_statline
              on_ice_statlines[skater_id]["#{goal_status}_as".to_sym] += 1
              on_ice_statlines[skater_id]["#{goal_status}_#{goal_situation}".to_sym] += 1
              next unless opposing_skater_ids.length >= 3 && skater_ids.length >= 3

              on_ice_statlines[skater_id]["#{goal_status}_#{goal_player_counts}".to_sym] += 1
            end
          end

          on_ice_statlines
        end

        private

        def on_ice_statlines
          @on_ice_statlines ||= @skater_ids.map { |s_id| [s_id.to_s, blank_statline] }.to_h
        end

        def find_goal_situation(goal, on_scoring_team)
          return "pp" if (goal[:properties][:isPowerPlay] == "1" && on_scoring_team) || (goal[:properties][:isShortHanded] == "1" && !on_scoring_team)

          return "sh" if goal[:properties][:isShortHanded] == "1" && on_scoring_team || (goal[:properties][:isPowerPlay] == "1" && !on_scoring_team)

          return "en" if goal[:properties][:isEmptyNet] == "1" && on_scoring_team

          return "ex" if goal[:properties][:isEmptyNet] == "1" && !on_scoring_team

          if goal[:plus_players].length == 6 ||
             (goal[:properties][:isPowerPlay] == "1" && goal[:plus_players].length == goal[:minus_players].length) ||
             (goal[:properties][:isShortHanded] == "1" && goal[:plus_players].length == goal[:minus_players].length)

            return on_scoring_team ? "ex" : "en"
          end

          "ev"
        end

        def blank_statline
          {
            gf_as: 0,
            gf_ev: 0,
            gf_pp: 0,
            gf_sh: 0,
            gf_ex: 0,
            gf_en: 0,
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
      end
    end
  end
end
