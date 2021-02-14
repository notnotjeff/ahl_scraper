# frozen_string_literal: true

module AhlScraper
  module Games
    module Format
      class TimeSplits
        def initialize(goals, team_id, current_state)
          @goals = goals
          @team_id = team_id
          @current_state = current_state
        end

        def call
          @times = { leading: 0, trailing: 0, tied: 0 }
          @time_elapsed = 0
          calculate_time_splits
          @times
        end

        private

        def calculate_time_splits
          @score_difference = 0
          @goals.each.with_index do |goal, i|
            goal_time_elapsed = Helpers::PeriodTime.new(goal[:time], goal[:period][:id].to_i).to_elapsed
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
          if !@current_state[:overtime]
            3600
          else
            3900
          end
        end

        def current_time
          return if @current_state[:status] == "finished"

          return total_game_time if @current_state[:period] =~ /SO/

          Helpers::PeriodTime.new(@current_state[:time], @current_state[:period_number]).to_elapsed
        end
      end
    end
  end
end
