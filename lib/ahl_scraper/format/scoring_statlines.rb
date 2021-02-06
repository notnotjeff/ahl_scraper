# frozen_string_literal: true

require "ahl_scraper/games/format/merge_goal"

module AhlScraper
  module Format
    class ScoringStatlines
      attr_reader :skater_data, :goal_data, :opts, :statlines

      def initialize(skater_data, goal_data, opts = {})
        @skater_data = skater_data
        @goal_data = goal_data
        @opts = opts
        @statlines = {}
      end

      def call
        create_blank_statlines_for_skaters
        add_scoring_data_to_statlines

        statlines.keys.map { |s| Skater.new(statlines[s], opts) }
      end

      private

      def create_blank_statlines_for_skaters
        skater_data.each { |s| statlines[s[:info][:id]] = blank_statline(s[:info], s[:starting] == 1, s[:status]) }
      end

      def blank_statline(info, starting, captaincy)
        {
          id: info[:id],
          first_name: info[:firstName],
          last_name: info[:lastName],
          starting: starting,
          captaincy: %w[A C].include?(captaincy) ? captaincy : nil,
          home_team: opts[:home_team],
          team_id: opts[:team_id],
          team_abbreviation: opts[:team_abbreviation],
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

      def add_scoring_data_to_statlines
        goal_data.each do |goal|
          MergeGoal.new(goal, statlines).call
        end
      end
    end
  end
end
