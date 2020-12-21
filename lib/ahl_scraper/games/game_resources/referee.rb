# frozen_string_literal: true

module AhlScraper
  module Games
    class Referee < GameResource
      def first_name
        @first_name ||= @raw_data[:firstName]
      end

      def last_name
        @last_name ||= @raw_data[:lastName]
      end

      def jersey_number
        @jersey_number ||= @raw_data[:jerseyNumber]
      end

      def role
        @role ||= @raw_data[:role]
      end
    end
  end
end
