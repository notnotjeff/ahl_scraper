# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      module ScoringStatlines
        module_function

        def format(skater_data, goal_data)
          statlines = {}
          skater_data.each do |s|
            statlines[s[:info][:id]] = {
              first_name: s[:info][:firstName],
              last_name: s[:info][:lastName],
              goals_as: 0,
              a1_as: 0,
              a2_as: 0,
              points_as: 0,
              goals_es: 0,
              a1_es: 0,
              a2_es: 0,
              points_es: 0,
              goals_5v5: 0,
              a1_5v5: 0,
              a2_5v5: 0,
              points_5v5: 0,
              goals_pp: 0,
              a1_pp: 0,
              a2_pp: 0,
              points_pp: 0,
            }
          end
          goal_data.each do |goal|
            statlines[goal[:scored_by][:id]][:goals_as] += 1
            statlines[goal[:assists][0].try(:[], :id)][:a1_as] += 1
            statlines[goal[:assists][1].try(:[], :id)][:a2_as] += 1

            statlines[goal[:scored_by][:id]][:points_as] += 1
            statlines[goal[:assists][0].try(:[], :id)][:points_as] += 1
            statlines[goal[:assists][1].try(:[], :id)][:points_as] += 1

            if goal[:plus_players].length == goal[:minus_players].length
              statlines[goal[:scored_by][:id]][:goals_es] += 1
              statlines[goal[:assists][0].try(:[], :id)][:a1_es] += 1
              statlines[goal[:assists][1].try(:[], :id)][:a2_es] += 1

              statlines[goal[:scored_by][:id]][:points_es] += 1
              statlines[goal[:assists][0].try(:[], :id)][:points_es] += 1
              statlines[goal[:assists][1].try(:[], :id)][:points_es] += 1

              next unless goal[:plus_players].length == 5 && goal[:minus_players].length == 5

              statlines[goal[:scored_by][:id]][:goals_5v5] += 1
              statlines[goal[:assists][0].try(:[], :id)][:a1_5v5] += 1
              statlines[goal[:assists][1].try(:[], :id)][:a2_5v5] += 1

              statlines[goal[:scored_by][:id]][:points_5v5] += 1
              statlines[goal[:assists][0].try(:[], :id)][:points_5v5] += 1
              statlines[goal[:assists][1].try(:[], :id)][:points_5v5] += 1
            elsif goal[:plus_players].length > goal[:minus_players].length && goal[:properties].is_power_play.to_i.positive?
              statlines[goal[:scored_by][:id]][:goals_pp] += 1
              statlines[goal[:assists][0].try(:[], :id)][:a1_pp] += 1
              statlines[goal[:assists][1].try(:[], :id)][:a2_pp] += 1

              statlines[goal[:scored_by][:id]][:points_pp] += 1
              statlines[goal[:assists][0].try(:[], :id)][:points_pp] += 1
              statlines[goal[:assists][1].try(:[], :id)][:points_pp] += 1
            end
          end
          statlines
        end
      end
    end
  end
end
