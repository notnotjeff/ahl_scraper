# frozen_string_literal: true

module AhlScraper
  module Games
    class Penalty < Resource
      def number
        @number ||= @opts[:number]
      end

      def period
        @period ||= @raw_data.dig(:period, :id).to_i
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

      def taken_by
        @taken_by ||= {
          id: @raw_data.dig(:takenBy, :id),
          first_name: @raw_data.dig(:takenBy, :firstName),
          last_name: @raw_data.dig(:takenBy, :lastName),
          jersey_number: @raw_data.dig(:takenBy, :jerseyNumber),
          position: @raw_data.dig(:takenBy, :position),
          birthdate: @raw_data.dig(:takenBy, :birthdate),
        }
      end

      def served_by
        @served_by ||= {
          id: @raw_data.dig(:servedBy, :id),
          first_name: @raw_data.dig(:servedBy, :firstName),
          last_name: @raw_data.dig(:servedBy, :lastName),
          jersey_number: @raw_data.dig(:servedBy, :jerseyNumber),
          position: @raw_data.dig(:servedBy, :position),
          birthdate: @raw_data.dig(:servedBy, :birthdate),
        }
      end

      def penalized_team
        @penalized_team ||= @raw_data[:againstTeam]
      end

      def minutes
        @minutes ||= @raw_data[:minutes]
      end

      def duration
        @duration ||= "#{minutes}:00"
      end

      def duration_in_seconds
        @duration_in_seconds ||= minutes * 60
      end

      def description
        @description ||= @raw_data[:description]
      end

      def rule_number
        @rule_number ||= @raw_data[:rule_number]
      end

      def power_play?
        @power_play ||= @raw_data[:isPowerPlay]
      end

      def penalty_type
        @penalty_type ||=
          case @raw_data[:description]
          when /double minor/i
            :double_minor
          when /major/i
            :major
          when /fighting/i
            :fight
          when /game misconduct/i
            :game_misconduct
          when /misconduct/i
            :misconduct
          else
            :minor
          end
      end

      private

      def period_time
        @period_time ||= PeriodTimeHelper.new(time, period)
      end
    end
  end
end
