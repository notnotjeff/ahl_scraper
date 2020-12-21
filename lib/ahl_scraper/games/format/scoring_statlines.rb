# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      class ScoringStatlines
        # TODO: TEST THIS!
        attr_reader :skater_data, :goal_data, :opts

        def initialize(skater_data, goal_data, opts = {})
          @skater_data = skater_data
          @goal_data = goal_data
          @opts = opts
        end

        def call
          @statlines = {}
          skater_data.each { |s| @statlines[s[:info][:id]] = blank_statline(s[:info], s[:starting] == 1, s[:status]) }
          add_scoring_data_to_statlines

          @statlines.keys.map { |s| Skater.new(@statlines[s]) }
        end

        private

        def blank_statline(info, starting, captaincy)
          {
            id: info[:id],
            first_name: info[:first_name],
            last_name: info[:last_name],
            starting: starting,
            captaincy: captaincy,
            home_team: @opts[:home_team],
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

        def add_scoring_data_to_statlines # rubocop:disable Metrics/AbcSize
          goal_data.each do |goal|
            @statlines[goal[:scored_by][:id]][:goals_as] += 1
            @statlines[goal[:assists][0].try(:[], :id)][:a1_as] += 1
            @statlines[goal[:assists][1].try(:[], :id)][:a2_as] += 1

            @statlines[goal[:scored_by][:id]][:points_as] += 1
            @statlines[goal[:assists][0].try(:[], :id)][:points_as] += 1
            @statlines[goal[:assists][1].try(:[], :id)][:points_as] += 1

            if goal[:plus_players].length == goal[:minus_players].length
              @statlines[goal[:scored_by][:id]][:goals_es] += 1
              @statlines[goal[:assists][0].try(:[], :id)][:a1_es] += 1
              @statlines[goal[:assists][1].try(:[], :id)][:a2_es] += 1

              @statlines[goal[:scored_by][:id]][:points_es] += 1
              @statlines[goal[:assists][0].try(:[], :id)][:points_es] += 1
              @statlines[goal[:assists][1].try(:[], :id)][:points_es] += 1

              next unless goal[:plus_players].length == 5 && goal[:minus_players].length == 5

              @statlines[goal[:scored_by][:id]][:goals_5v5] += 1
              @statlines[goal[:assists][0].try(:[], :id)][:a1_5v5] += 1
              @statlines[goal[:assists][1].try(:[], :id)][:a2_5v5] += 1

              @statlines[goal[:scored_by][:id]][:points_5v5] += 1
              @statlines[goal[:assists][0].try(:[], :id)][:points_5v5] += 1
              @statlines[goal[:assists][1].try(:[], :id)][:points_5v5] += 1
            elsif goal[:plus_players].length > goal[:minus_players].length && goal[:properties].is_power_play.to_i.positive?
              @statlines[goal[:scored_by][:id]][:goals_pp] += 1
              @statlines[goal[:assists][0].try(:[], :id)][:a1_pp] += 1
              @statlines[goal[:assists][1].try(:[], :id)][:a2_pp] += 1

              @statlines[goal[:scored_by][:id]][:points_pp] += 1
              @statlines[goal[:assists][0].try(:[], :id)][:points_pp] += 1
              @statlines[goal[:assists][1].try(:[], :id)][:points_pp] += 1
            end
          end
        end
      end
    end
  end
end
