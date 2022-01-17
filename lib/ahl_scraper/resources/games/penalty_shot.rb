# frozen_string_literal: true

module AhlScraper
  module Games
    class PenaltyShot < Resource
      def number
        @number ||= @opts[:number]
      end

      def shooter
        @shooter ||= {
          id: @raw_data[:shooter][:id],
          first_name: @raw_data[:shooter][:firstName],
          last_name: @raw_data[:shooter][:lastName],
          jersey_number: @raw_data[:shooter][:jerseyNumber],
          position: @raw_data[:shooter][:position],
        }
      end

      def goalie
        @goalie ||= {
          id: @raw_data[:goalie][:id],
          first_name: @raw_data[:goalie][:firstName],
          last_name: @raw_data[:goalie][:lastName],
          jersey_number: @raw_data[:goalie][:jerseyNumber],
          position: @raw_data[:goalie][:position],
        }
      end

      def shooting_team
        @shooting_team ||= {
          id: @raw_data[:shooter_team][:id],
          full_name: @raw_data[:shooter_team][:name],
          city: @raw_data[:shooter_team][:city],
          name: @raw_data[:shooter_team][:nickname],
          abbreviation: @raw_data[:shooter_team][:abbreviation],
          logo_url: @raw_data[:shooter_team][:logo],
        }
      end

      def period
        @period ||= @raw_data[:period][:id].to_i
      end

      def time
        @time ||= @raw_data[:time]
      end

      def period_time_in_seconds
        @period_time_in_seconds ||= period_time.to_sec
      end

      def game_time_elapsed
        @game_time_elapsed ||= period_time.to_elapsed
      end

      def scored?
        @scored ||= @raw_data[:isGoal] == true
      end

      def scored_in_words
        @scored_in_words ||=
          if scored?
            "Scored"
          else
            "Missed"
          end
      end

      private

      def period_time
        @period_time ||= PeriodTimeHelper.new(time, period)
      end
    end
  end
end
