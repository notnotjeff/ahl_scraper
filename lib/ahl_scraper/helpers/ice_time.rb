# frozen_string_literal: true

module AhlScraper
  module Helpers
    class IceTime
      attr_reader :time

      def initialize(time)
        @time = time
      end

      def to_seconds
        ice_time = time.split(":")
        ice_time[0].to_i * 60 + ice_time[1].to_i
      end

      alias to_sec to_seconds
    end
  end
end
