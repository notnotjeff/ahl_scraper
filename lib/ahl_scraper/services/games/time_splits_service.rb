# frozen_string_literal: true

module AhlScraper
  module Games
    class TimeSplitsService
      def initialize(goals, team_id, current_state, game_properties)
        @goals = goals
        @team_id = team_id
        @current_state = current_state
        @game_properties = game_properties
      end

      def call
        @times = { leading: 0, trailing: 0, tied: 0 }
        @time_elapsed = @game_properties[:game_start_time_in_seconds] || 0
        calculate_time_splits
        @times
      end

      private

      def calculate_time_splits
        @score_difference = 0
        @goals.each.with_index do |goal, i|
          goal_time_elapsed = PeriodTimeHelper.new(goal[:time], goal[:period][:id].to_i).to_elapsed
          add_time_based_on_score(@score_difference, goal_time_elapsed - @time_elapsed)
          @score_difference += goal[:team][:id] == @team_id ? 1 : -1
          @time_elapsed = goal_time_elapsed

          next unless (i + 1) == @goals.length

          add_time_remaining(@time_elapsed) if @current_state[:shootout] || !@current_state[:overtime]
        end
      end

      def add_time_based_on_score(difference, time)
        if difference.positive?
          @times[:leading] += time
        elsif difference.negative?
          @times[:trailing] += time
        else
          @times[:tied] += time
        end
      end

      def add_time_remaining(time)
        to_end_of_game = (current_time || total_game_time) - time
        add_time_based_on_score(@score_difference, to_end_of_game)
      end

      def total_game_time
        return @game_properties[:game_end_time_in_seconds] if @game_properties[:game_end_time_in_seconds]

        return 3600 unless @current_state[:overtime]

        return 3900 unless @current_state[:playoffs]

        3600 + (1200 * @game_properties[:overtime_periods])
      end

      def current_time
        return unless @current_state[:status] == "in_progress"

        return total_game_time if @current_state[:period] =~ /SO/

        PeriodTimeHelper.new(@current_state[:time], @current_state[:period_number]).to_elapsed
      end
    end
  end
end
