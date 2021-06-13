# frozen_string_literal: true

module AhlScraper
  module Games
    class ShootoutStatlinesService
      def initialize(shootout_data, team_id, skater_ids)
        @shootout_data = shootout_data
        @team_id = team_id
        @skater_ids = skater_ids
      end

      def call
        return {} unless @shootout_data

        @shootout_data.each do |shootout_attempt|
          skater_id = shootout_attempt[:shooter][:id].to_s
          shootout_statlines[skater_id] ||= blank_statline

          shootout_statlines[skater_id][:attempts] += 1
          shootout_statlines[skater_id][:goals] += 1 if shootout_attempt[:isGoal]
          shootout_statlines[skater_id][:game_winners] += 1 if shootout_attempt[:isGameWinningGoal]
        end

        shootout_statlines
      end

      private

      def shootout_statlines
        @shootout_statlines ||= @skater_ids.map { |s_id| [s_id.to_s, blank_statline] }.to_h
      end

      def blank_statline
        {
          attempts: 0,
          goals: 0,
          game_winners: 0,
        }
      end
    end
  end
end
