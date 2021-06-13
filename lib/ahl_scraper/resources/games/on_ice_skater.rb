# frozen_string_literal: true

module AhlScraper
  module Games
    class OnIceSkater < Resource
      def id
        @id ||= @raw_data[:id]
      end

      def goal_id
        @goal_id ||= @opts[:goal_id]
      end

      def first_name
        @first_name ||= @raw_data[:firstName]
      end

      def last_name
        @last_name ||= @raw_data[:lastName]
      end

      def jersey_number
        @jersey_number ||= @raw_data[:jerseyNumber]
      end

      def position
        @position ||= @raw_data[:position]
      end

      def scoring_team?
        @scoring_team ||= @opts[:scoring_team]
      end
    end
  end
end
