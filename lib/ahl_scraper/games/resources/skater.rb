# frozen_string_literal: true

module AhlScraper
  module Games
    class Skater < GameResource
      def id
        @id ||= @raw_data[:id]
      end

      def first_name
        @first_name ||= @raw_data[:first_name]
      end

      def last_name
        @last_name ||= @raw_data[:last_name]
      end

      def team_id
        @team_id ||= @raw_data[:team_id]
      end

      def team_abbreviation
        @team_abbreviation ||= @raw_data[:team_abbreviation]
      end

      def starting
        @starting ||= @raw_data[:starting]
      end

      def captaincy
        @captaincy ||= @raw_data[:captaincy]
      end

      def home_team
        @home_team ||= @raw_data[:home_team]
      end

      def stats
        @stats ||= {
          **@raw_data.slice(*(@raw_data.keys - %i[id first_name last_name starting captaincy home_team team_id team_abbreviation])),
        }
      end
    end
  end
end
