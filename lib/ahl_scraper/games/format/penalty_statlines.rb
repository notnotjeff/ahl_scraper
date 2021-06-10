# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      class PenaltyStatlines
        def initialize(penalty_data, team_id, skater_ids)
          @penalty_data = penalty_data
          @team_id = team_id
          @skater_ids = skater_ids
        end

        def call
          @penalty_data.each do |penalty|
            next unless penalty[:takenBy]

            skater_id = penalty_statlines[penalty[:takenBy][:id].to_s] ? penalty[:takenBy][:id].to_s : false
            next unless skater_id

            penalty_statlines[skater_id][penalty_type(penalty)] += 1
            penalty_statlines[skater_id][:penalty_minutes] += penalty[:minutes].to_i
          end

          penalty_statlines
        end

        private

        def penalty_statlines
          @penalty_statlines ||= @skater_ids.map { |s_id| [s_id.to_s, blank_statline] }.to_h
        end

        def blank_statline
          {
            penalty_minutes: 0,
            minors: 0,
            double_minors: 0,
            majors: 0,
            fights: 0,
            misconducts: 0,
            game_misconducts: 0,
          }
        end

        def penalty_type(penalty)
          case penalty[:description]
          when /double minor/i
            :double_minors
          when /major/i
            :majors
          when /fighting/i
            :fights
          when /game misconduct/i
            :game_misconducts
          when /misconduct/i
            :misconducts
          else
            :minors
          end
        end
      end
    end
  end
end
