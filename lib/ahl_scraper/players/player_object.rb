# frozen_string_literal: true

module AhlScraper
  module Players
    class PlayerObject < Resource
      def initialize(raw_data)
        @raw_data = raw_data
      end

      def id
        @id ||= @raw_data.dig(:bio, :row, :player_id).to_i
      end

      def name
        @name ||= @raw_data.dig(:bio, :row, :name)
      end

      def shoots
        @shoots ||= @raw_data.dig(:bio, :row, :shoots)
      end

      def birthplace
        @birthplace ||= @raw_data.dig(:bio, :row, :birthplace)
      end

      def height
        @height ||= @raw_data.dig(:bio, :row, :height_hyphenated)
      end

      def birthdate
        @birthdate ||= @raw_data.dig(:bio, :row, :birthdate)
      end

      def number
        @number ||= @raw_data.dig(:bio, :row, :tp_jersey_number).to_i
      end

      def position
        @position ||= @raw_data.dig(:bio, :row, :position)
      end

      def weight
        @weight ||= @raw_data.dig(:bio, :row, :w).to_i
      end

      def rookie?
        @rookie ||= @raw_data.dig(:stats, :prop, :rookie, :rookie) == "1"
      end
    end
  end
end
