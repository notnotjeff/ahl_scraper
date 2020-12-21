# frozen_string_literal: true

module AhlScraper
  module Games
    class Star < GameResource
      def id
        @id ||= @raw_data[:player][:id]
      end

      def first_name
        @first_name ||= @raw_data[:player][:firstName]
      end

      def last_name
        @last_name ||= @raw_data[:player][:lastName]
      end

      def team_id
        @team_id ||= @raw_data[:team][:id]
      end

      def jersey_name
        @jersey_name ||= @raw_data[:player][:jerseyNumber]
      end

      def position
        @position ||= @raw_data[:player][:position]
      end

      def birthdate
        @birthdate ||= @raw_data[:player][:birthDate]
      end

      def goalie?
        @goalie ||= @raw_data[:isGoalie]
      end

      def image_url
        @image_url ||= @raw_data[:playerImage]
      end
    end
  end
end
