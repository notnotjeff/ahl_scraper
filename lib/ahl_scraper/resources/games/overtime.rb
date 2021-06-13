# frozen_string_literal: true

module AhlScraper
  module Games
    class Overtime < Resource
      def number
        @number ||= @raw_data[:info][:id].to_i - 3
      end

      def name
        @name ||= "#{@raw_data[:info][:longName]}#{number}"
      end

      def length
        @length ||= ElapsedTimeHelper.new(length_in_seconds).to_min
      end

      def length_in_seconds
        @length_in_seconds ||=
          if scoring?
            PeriodTimeHelper.new(@raw_data[:goals][0][:time]).to_sec
          else
            @opts[:regular_season] ? 300 : 1200
          end
      end

      def scoring?
        @scoring ||= @raw_data[:goals].any?
      end

      def home_goals
        @home_goals ||= @raw_data[:stats][:homeGoals].to_i
      end

      def home_sog
        @home_sog ||= @raw_data[:stats][:homeShots].to_i
      end

      def away_goals
        @away_goals ||= @raw_data[:stats][:visitingGoals].to_i
      end

      def away_sog
        @away_sog ||= @raw_data[:stats][:visitingShots].to_i
      end
    end
  end
end
