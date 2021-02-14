# frozen_string_literal: true

module AhlScraper
  module Games
    class Team < GameResource
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
          shots: @opts[:shots].map { |period| period[home_team? ? :home : :away] }.reduce(:+),
          p1_shots: @opts[:shots][0][home_team? ? :home : :away],
          p2_shots: @opts[:shots][1][home_team? ? :home : :away],
          p3_shots: @opts[:shots][2][home_team? ? :home : :away],
          ot_shots: @opts[:shots][3..-1].map { |ot| ot[home_team? ? :home : :away] },
        }
      end

      def on_ice_stats
        @on_ice_stats ||= Format::TeamOnIceGoals.new(id, @opts[:goals]).call
      end

      def time_splits
        @time_splits ||= Format::TimeSplits.new(@opts[:goals], id, @opts[:current_state]).call
      end

      private

      def score
        @score ||= @opts[:shootout] && @opts[:winning_team_id] == id ? @raw_data[:stats][:goals] + 1 : @raw_data[:stats][:goals]
      end
    end
  end
end
