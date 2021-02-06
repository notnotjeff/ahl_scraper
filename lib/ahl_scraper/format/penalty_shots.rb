# frozen_string_literal: true

module AhlScraper
  module Format
    class PenaltyShots
      attr_reader :penalty_shot_data

      def initialize(penalty_shot_data)
        @penalty_shot_data = penalty_shot_data
      end

      def call
        ordered_penalty_shots.map.with_index { |ps, i| PenaltyShot.new(ps, { number: i + 1 }) }
      end

      private

      def ordered_penalty_shots
        @ordered_penalty_shots ||= penalty_shot_data.sort do |a, b|
          [a[:period][:id].to_i, convert_time(a[:time])] <=> [b[:period][:id].to_i, convert_time(b[:time])]
        end
      end

      def convert_time(game_time)
        time = game_time.split(":")
        time[0].to_i * 60 + time[1].to_i
      end
    end
  end
end
