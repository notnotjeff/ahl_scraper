# frozen_string_literal: true

module AhlScraper
  module Games
    class ScoringStatlinesService
      def initialize(goal_data, skater_ids, opts = {})
        @goal_data = goal_data
        @skater_ids = skater_ids
        @opts = opts
      end

      def call
        @goal_data.each do |goal|
          plus_player_count = goal[:plus_players].length
          minus_player_count = goal[:minus_players].length
          goalscorer_id = scoring_statlines[goal[:scoredBy][:id].to_s] ? goal[:scoredBy][:id].to_s : false # Make sure goal does not belong to goalie
          a1_id = goal[:assists][0]&.dig(:id) && scoring_statlines[goal[:assists][0]&.dig(:id).to_s] ? goal[:assists][0]&.dig(:id).to_s : false # Make sure assist exists and does not belong to goalie
          a2_id = goal[:assists][1]&.dig(:id) && scoring_statlines[goal[:assists][1]&.dig(:id).to_s] ? goal[:assists][1]&.dig(:id).to_s : false # Make sure assist exists and does not belong to goalie

          add_points(goalscorer_id, a1_id, a2_id, "as")
          if goal[:properties][:isPenaltyShot].to_i.positive?
            scoring_statlines[goalscorer_id][:goals_ps] += 1
          elsif extra_skater?(goal, plus_player_count, minus_player_count)
            add_points(goalscorer_id, a1_id, a2_id, "ex")
          elsif goal[:properties][:isEmptyNet].to_i.positive?
            add_points(goalscorer_id, a1_id, a2_id, "en")
          elsif goal[:properties][:isPowerPlay].to_i.positive?
            add_points(goalscorer_id, a1_id, a2_id, "pp")
          elsif goal[:properties][:isShortHanded].to_i.positive?
            add_points(goalscorer_id, a1_id, a2_id, "sh")
          elsif plus_player_count == minus_player_count
            add_points(goalscorer_id, a1_id, a2_id, "ev")
            add_points(goalscorer_id, a1_id, a2_id, "5v5") if plus_player_count == 5 && minus_player_count == 5
          end
        end

        scoring_statlines
      end

      private

      def scoring_statlines
        @scoring_statlines ||= @skater_ids.map { |s_id| [s_id.to_s, blank_statline] }.to_h
      end

      def blank_statline
        {
          goals_as: 0,
          a1_as: 0,
          a2_as: 0,
          points_as: 0,
          p1_as: 0,
          goals_ps: 0,
          p1_ps: 0,
          goals_ev: 0,
          a1_ev: 0,
          a2_ev: 0,
          points_ev: 0,
          p1_ev: 0,
          goals_5v5: 0,
          a1_5v5: 0,
          a2_5v5: 0,
          points_5v5: 0,
          p1_5v5: 0,
          goals_pp: 0,
          a1_pp: 0,
          a2_pp: 0,
          points_pp: 0,
          p1_pp: 0,
          goals_sh: 0,
          a1_sh: 0,
          a2_sh: 0,
          points_sh: 0,
          p1_sh: 0,
          goals_ex: 0,
          a1_ex: 0,
          a2_ex: 0,
          points_ex: 0,
          p1_ex: 0,
          goals_en: 0,
          a1_en: 0,
          a2_en: 0,
          points_en: 0,
          p1_en: 0,
        }
      end

      def add_points(goalscorer_id, a1_id, a2_id, situation)
        if goalscorer_id
          scoring_statlines[goalscorer_id]["goals_#{situation}".to_sym] += 1
          scoring_statlines[goalscorer_id]["p1_#{situation}".to_sym] += 1
        end
        if a1_id
          scoring_statlines[a1_id]["a1_#{situation}".to_sym] += 1
          scoring_statlines[a1_id]["p1_#{situation}".to_sym] += 1
        end
        scoring_statlines[a2_id]["a2_#{situation}".to_sym] += 1 if a2_id

        scoring_statlines[goalscorer_id]["points_#{situation}".to_sym] += 1 if goalscorer_id
        scoring_statlines[a1_id]["points_#{situation}".to_sym] += 1 if a1_id
        scoring_statlines[a2_id]["points_#{situation}".to_sym] += 1 if a2_id
      end

      def extra_skater?(goal, scoring_team_player_count, defending_team_skater_count)
        return true if scoring_team_player_count == 6

        if (goal[:isPowerPlay].to_i.positive? || goal[:isShortHanded].to_i.positive?) && scoring_team_player_count == defending_team_skater_count
          return true
        end

        false
      end
    end
  end
end
