# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      class PenaltyShotStatlines
        def initialize(penalty_shot_data, team_id, skater_ids)
          @penalty_shot_data = penalty_shot_data
          @team_id = team_id
          @skater_ids = skater_ids
        end

        def call
          @penalty_shot_data.each do |penalty_shot|
            skater_id = penalty_shot[:shooter][:id].to_s
            penalty_shot_statlines[skater_id] ||= blank_statline

            penalty_shot_statlines[skater_id][:attempts] += 1
            penalty_shot_statlines[skater_id][:goals] += 1 if penalty_shot[:isGoal]
          end

          penalty_shot_statlines
        end

        private

        def penalty_shot_statlines
          @penalty_shot_statlines ||= @skater_ids.map { |s_id| [s_id.to_s, blank_statline] }.to_h
        end

        def blank_statline
          {
            attempts: 0,
            goals: 0,
          }
        end
      end
    end
  end
end
