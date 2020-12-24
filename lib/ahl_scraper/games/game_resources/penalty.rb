# frozen_string_literal: true

module AhlScraper
  module Games
    class Penalty < GameResource
      def number
        @number ||= @opts[:number]
      end

      def period
        @period ||= @raw_data.dig(:period, :id)
      end

      def time
        @time ||= @raw_data[:time]
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

      def opposing_team
        @opposing_team ||= @raw_data[:againstTeam]
      end

      def minutes
        @minutes ||= @raw_data[:minutes]
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
    end
  end
end
