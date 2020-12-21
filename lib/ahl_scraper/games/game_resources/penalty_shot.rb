# frozen_string_literal: true

module AhlScraper
  module Games
    class PenaltyShot < GameResource
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

      def time_in_seconds
        @time_in_seconds ||= convert_time(time)
      end

      def scored?
        @scored ||= @raw_data[:isGoal] == true
      end

      private

      def convert_time(game_time)
        time = game_time.split(":")
        time[0].to_i * 60 + time[1].to_i
      end
    end
  end
end
