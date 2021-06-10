# frozen_string_literal: true

module AhlScraper
  module Players
    class PlayerObject < Resource
      def initialize(raw_data)
        @raw_data = raw_data
      end

      def id
        @id ||= @raw_data.dig(:info, :playerId).to_i
      end

      def name
        @name ||= "#{first_name} #{last_name}"
      end

      def first_name
        @first_name ||= @raw_data.dig(:info, :firstName)
      end

      def last_name
        @last_name ||= @raw_data.dig(:info, :lastName)
      end

      def shoots
        @shoots ||= @raw_data.dig(:info, :shoots)
      end

      def catches
        @catches ||= @raw_data.dig(:info, :catches)
      end

      def birthplace
        @birthplace ||= @raw_data.dig(:info, :birthPlace)&.strip
      end

      def height
        @height ||= @raw_data.dig(:info, :height_hyphenated)
      end

      def birthdate
        @birthdate ||= @raw_data.dig(:info, :birthDate)
      end

      def draft_year
        @draft_year ||= birthdate ? Helpers::Birthdate.new(birthdate).draft_year : "Not Found"
      end

      def current_age
        @current_age ||= birthdate ? Helpers::Birthdate.new(birthdate).current_age : "Not Found"
      end

      def jersey_number
        @jersey_number ||= @raw_data.dig(:info, :jerseyNumber).to_i
      end

      def position
        @position ||= @raw_data.dig(:info, :position)
      end

      def weight
        @weight ||= @raw_data.dig(:info, :weight).to_i
      end
    end
  end
end
