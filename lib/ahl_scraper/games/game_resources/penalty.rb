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
        @taken_by || @raw_data[:takenBy]
      end

      def served_by
        @served_by || @raw_data[:servedBy]
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
