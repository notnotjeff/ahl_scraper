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
          goals: @raw_data[:stats][:goals],
          hits: @raw_data[:stats][:hits],
          power_play_goals: @raw_data[:stats][:powerPlayGoals],
          power_play_opportunities: @raw_data[:stats][:powerPlayOpportunities],
          goal_count: @raw_data[:stats][:goalCount],
          penalty_minute_count: @raw_data[:stats][:penaltyMinuteCount],
          infraction_count: @raw_data[:stats][:infractionCount],
        }
      end
    end
  end
end
