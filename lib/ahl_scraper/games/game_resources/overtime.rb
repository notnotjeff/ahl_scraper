# frozen_string_literal: true

module AhlScraper
  module Games
    class Overtime < GameResource
      def number
        @number ||= @raw_data[:info][:id].to_i - 3
      end

      def name
        @name ||= @raw_data[:info][:longName] + @raw_data[:info][:id]
      end

      def length
        @length ||= convert_time_to_string(length_in_seconds)
      end

      def length_in_seconds
        @length_in_seconds ||=
          if scoring?
            convert_time(@raw_data[:goals][0][:time])
          else
            @opts[:regular_season] ? 300 : 1200
          end
      end

      def scoring?
        @scoring ||= @raw_data[:goals].any?
      end

      def home_goals
        @home_goals ||= @raw_data[:stats][:homeGoals]
      end

      def home_shots
        @home_shots ||= @raw_data[:stats][:homeShots]
      end

      def away_goals
        @away_goals ||= @raw_data[:stats][:visitingGoals]
      end

      def away_shots
        @away_shots ||= @raw_data[:stats][:visitingShots]
      end

      private

      # TODO: MAKE THESE INTO HELPER METHOD AND REPLACE WHEREVER ELSE THEY ARE USED
      def convert_time(game_time)
        time = game_time.split(":")
        time[0].to_i * 60 + time[1].to_i
      end

      def convert_time_to_string(game_time)
        minutes = game_time / 60
        seconds = game_time % 60
        "#{minutes}:#{seconds.to_s.rjust(2, '0')}"
      end
    end
  end
end
