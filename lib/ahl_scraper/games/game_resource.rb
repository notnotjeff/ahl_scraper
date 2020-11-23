# frozen_string_literal: true

module AhlScraper
  module Games
    class GameResource
      def initialize(raw_data, opts = {})
        @raw_data = raw_data
        @opts = opts
      end

      def inspect
        "#<#{self.class}:0x#{object_id.to_s(16)}>"
      end
    end
  end
end
