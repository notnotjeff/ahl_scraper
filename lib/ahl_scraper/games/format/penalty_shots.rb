# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      class PenaltyShots
        # TODO: TEST THIS
        attr_reader :penalty_shot_data

        def initialize(penalty_shot_data)
          @penalty_shot_data = penalty_shot_data
        end

        def call
          penalty_shot_data.sort { |a, b| [a[:period][:id].to_i, convert_time(a[:time])] <=> [b[:period][:id].to_i, convert_time(b[:time])] }
                           .map.with_index { |ps, i| PenaltyShot.new(ps, { number: i + 1 }) }
        end

        private

        def convert_time(game_time)
          time = game_time.split(":")
          time[0].to_i * 60 + time[1].to_i
        end
      end
    end
  end
end
