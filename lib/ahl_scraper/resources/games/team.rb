# frozen_string_literal: true

module AhlScraper
  module Games
    class Team < Resource
      def id
        @id ||= @raw_data[:info][:id]
      end

      def full_name
        @full_name ||= @raw_data[:info][:name]
      end

      def city
        @city ||= @raw_data[:info][:city]
      end

      def name
        @name ||= @raw_data[:info][:nickname]
      end

      def abbreviation
        @abbreviation ||= @raw_data[:info][:abbreviation]
      end

      def logo_url
        @logo_url ||= @raw_data[:info][:logo]
      end

      def home_team?
        @home_team ||= @opts[:home_team]
      end

      def stats
        @stats ||= {
          score: score,
          hits: @raw_data[:stats][:hits],
          power_play_goals: @raw_data[:stats][:powerPlayGoals],
          power_play_opportunities: @raw_data[:stats][:powerPlayOpportunities],
          goals: @raw_data[:stats][:goalCount],
          penalty_minute_count: @raw_data[:stats][:penaltyMinuteCount],
          infraction_count: @raw_data[:stats][:infractionCount],
        }
      end

      def shot_stats
        @shot_stats ||= {
          sog: @opts[:shots].map { |period| period[home_team? ? :home : :away] }.reduce(:+),
          p1_sog: @opts[:shots].dig(0, home_team? ? :home : :away),
          p2_sog: @opts[:shots].dig(1, home_team? ? :home : :away),
          p3_sog: @opts[:shots].dig(2, home_team? ? :home : :away),
          ot_sog: @opts[:shots][3..-1]&.map { |ot| ot[home_team? ? :home : :away].to_i },
        }
      end

      def goal_stats
        @goal_stats ||= {
          goals: @opts[:goal_totals].map { |period| period[home_team? ? :home : :away] }.reduce(:+),
          p1_goals: @opts[:goal_totals].dig(0, home_team? ? :home : :away),
          p2_goals: @opts[:goal_totals].dig(1, home_team? ? :home : :away),
          p3_goals: @opts[:goal_totals].dig(2, home_team? ? :home : :away),
          ot_goals: @opts[:goal_totals][3..-1]&.map { |ot| ot[home_team? ? :home : :away].to_i },
        }
      end

      def on_ice_stats
        @on_ice_stats ||= TeamOnIceGoalsService.new(id, @opts[:goals]).call
      end

      def time_splits
        @time_splits ||= TimeSplitsService.new(@opts[:goals], id, @opts[:current_state], @opts[:game_properties]).call
      end

      private

      def score
        @score ||= @opts[:shootout] && @opts[:winning_team_id] == id ? @raw_data[:stats][:goals] + 1 : @raw_data[:stats][:goals]
      end
    end
  end
end
