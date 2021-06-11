# frozen_string_literal: true

module AhlScraper
  module Games
    class Period < GameResource
      def number
        @number ||= @raw_data[:info][:id].to_i
      end

      def name
        @name ||= @raw_data[:info][:longName]
      end

      def home_goals
        @home_goals ||= @raw_data[:stats][:homeGoals]
      end

      def home_sog
        @home_sog ||= @raw_data[:stats][:homeShots]
      end

      def away_goals
        @away_goals ||= @raw_data[:stats][:visitingGoals]
      end

      def away_sog
        @away_sog ||= @raw_data[:stats][:visitingShots]
      end
    end
  end
end
