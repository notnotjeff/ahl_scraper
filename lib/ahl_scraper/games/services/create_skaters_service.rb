# frozen_string_literal: true

module AhlScraper
  module Games
    class CreateSkatersService
      def initialize(skater_data, goal_data, penalty_data, shootout_data, penalty_shot_data, opts)
        @skater_data = skater_data
        @goal_data = goal_data
        @penalty_data = penalty_data
        @shootout_data = shootout_data
        @penalty_shot_data = penalty_shot_data
        @opts = opts
      end

      def call
        scoring_statlines = Format::ScoringStatlines.new(team_goals, skater_ids, @opts).call
        on_ice_statlines = Format::OnIceStatlines.new(@goal_data, @opts[:team_id], skater_ids).call
        penalty_statlines = Format::PenaltyStatlines.new(@penalty_data, @opts[:team_id], skater_ids).call
        penalty_shot_statlines = Format::PenaltyShotStatlines.new(@penalty_shot_data, @opts[:team_id], skater_ids).call
        shootout_statlines = Format::ShootoutStatlines.new(@shootout_data, @opts[:team_id], skater_ids).call

        skaters.map do |s|
          id_key = s[:id].to_s
          Skater.new(
            s,
            {
              **@opts,
              scoring_statline: scoring_statlines[id_key],
              on_ice_statline: on_ice_statlines[id_key],
              penalty_statline: penalty_statlines[id_key],
              penalty_shot_statline: penalty_shot_statlines[id_key],
              shootout_statline: shootout_statlines[id_key],
            }
          )
        end
      end

      private

      def team_goals
        @goal_data.filter { |g| g[:team][:id] == @opts[:team_id] }
      end

      def skater_ids
        @skater_ids ||= @skater_data.map { |skater| skater[:info][:id] }
      end

      def skaters
        @skater_data.map do |s|
          {
            id: s[:info][:id],
            first_name: s[:info][:firstName],
            last_name: s[:info][:lastName],
            position: s[:info][:position],
            birthdate: s[:info][:birthDate],
            number: s[:info][:jerseyNumber],
            starting: s[:starting] == 1,
            captaincy: %w[A C].include?(s[:status]) ? s[:status] : nil,
            home_team: @opts[:home_team],
            team_id: @opts[:team_id],
            team_abbreviation: @opts[:team_abbreviation],
            faceoff_attempts: s[:stats][:faceoffAttempts],
            faceoff_wins: s[:stats][:faceoffWins],
            hits: s[:stats][:hits],
            penalty_minutes: s[:stats][:penaltyMinutes],
            sog_as: s[:stats][:shots],
          }
        end
      end
    end
  end
end
