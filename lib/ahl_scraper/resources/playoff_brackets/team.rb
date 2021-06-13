# frozen_string_literal: true

module AhlScraper
  module PlayoffBrackets
    class Team < Resource
      def id
        @id ||= @raw_data[:id].to_i
      end

      def city
        @city ||= @raw_data[:city]
      end

      def abbreviation
        @abbreviation ||= @raw_data[:team_code]
      end

      def full_name
        @full_name ||= @raw_data[:name]
      end

      def name
        @name ||= @raw_data[:name].sub(city, "").strip
      end

      def division
        @division ||= @raw_data[:division_long_name]
      end

      def conference_id
        @conference_id ||= @raw_data[:conf_id].to_i
      end

      def logo_url
        @logo_url ||= @raw_data[:logo]
      end
    end
  end
end
