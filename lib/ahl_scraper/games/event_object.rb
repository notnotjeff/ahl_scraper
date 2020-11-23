# frozen_string_literal: true

module AhlScraper
  module Games
    class EventObject
      attr_reader :raw_data

      def initialize(raw_data)
        @raw_data = raw_data
      end
    end
  end
end
