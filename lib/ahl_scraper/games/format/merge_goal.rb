# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      class MergeGoal
        attr_reader :goal, :statlines

        def initialize(goal, statlines)
          @goal = goal
          @statlines = statlines
        end

        def call
          add_all_situations_points
          if plus_player_count == minus_player_count
            add_even_strength_points
            add_5_on_5_points if plus_player_count == 5 && minus_player_count == 5
          elsif plus_player_count > minus_player_count && powerplay?
            add_power_play_points
          end
        end

        private

        def plus_player_count
          @plus_player_count ||= goal[:plus_players].length
        end

        def minus_player_count
          @minus_player_count ||= goal[:minus_players].length
        end

        def powerplay?
          @powerplay ||= goal[:properties][:isPowerPlay].to_i.positive?
        end

        def goalscorer_id
          if @goalscorer_id.nil?
            @goalscorer_id = statlines[goal[:scoredBy][:id]] ? goal[:scoredBy][:id] : false # Make sure goal does not belong to goalie
          end
          @goalscorer_id
        end

        def a1_id
          if @a1_id.nil?
            @a1_id = goal[:assists][0]&.dig(:id) && statlines[goal[:assists][0]&.dig(:id)] ? goal[:assists][0]&.dig(:id) : false # Make sure assist exists and does not belong to goalie
          end
          @a1_id
        end

        def a2_id
          if @a2_id.nil?
            @a2_id = goal[:assists][1]&.dig(:id) && statlines[goal[:assists][1]&.dig(:id)] ? goal[:assists][1]&.dig(:id) : false # Make sure assist exists and does not belong to goalie
          end
          @a2_id
        end

        def add_all_situations_points
          statlines[goalscorer_id][:goals_as] += 1 if goalscorer_id
          statlines[a1_id][:a1_as] += 1 if a1_id
          statlines[a2_id][:a2_as] += 1 if a2_id

          statlines[goalscorer_id][:points_as] += 1 if goalscorer_id
          statlines[a1_id][:points_as] += 1 if a1_id
          statlines[a2_id][:points_as] += 1 if a2_id
        end

        def add_even_strength_points
          statlines[goalscorer_id][:goals_es] += 1 if goalscorer_id
          statlines[a1_id][:a1_es] += 1 if a1_id
          statlines[a2_id][:a2_es] += 1 if a2_id

          statlines[goalscorer_id][:points_es] += 1 if goalscorer_id
          statlines[a1_id][:points_es] += 1 if a1_id
          statlines[a2_id][:points_es] += 1 if a2_id
        end

        def add_5_on_5_points
          statlines[goalscorer_id][:goals_5v5] += 1 if goalscorer_id
          statlines[a1_id][:a1_5v5] += 1 if a1_id
          statlines[a2_id][:a2_5v5] += 1 if a2_id

          statlines[goalscorer_id][:points_5v5] += 1 if goalscorer_id
          statlines[a1_id][:points_5v5] += 1 if a1_id
          statlines[a2_id][:points_5v5] += 1 if a2_id
        end

        def add_power_play_points
          statlines[goalscorer_id][:goals_pp] += 1 if goalscorer_id
          statlines[a1_id][:a1_pp] += 1 if a1_id
          statlines[a2_id][:a2_pp] += 1 if a2_id

          statlines[goalscorer_id][:points_pp] += 1 if goalscorer_id
          statlines[a1_id][:points_pp] += 1 if a1_id
          statlines[a2_id][:points_pp] += 1 if a2_id
        end
      end
    end
  end
end
