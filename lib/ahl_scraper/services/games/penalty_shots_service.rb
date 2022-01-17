# frozen_string_literal: true

module AhlScraper
  module Games
    class PenaltyShotsService
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
          [a[:period][:id].to_i, IceTimeHelper.new(a[:time]).to_sec] <=> [b[:period][:id].to_i, IceTimeHelper.new(b[:time]).to_sec]
        end
      end
    end
  end
end
