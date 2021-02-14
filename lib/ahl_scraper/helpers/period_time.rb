# frozen_string_literal: true

module AhlScraper
  module Helpers
    class PeriodTime
      attr_reader :time, :period

      def initialize(time, period)
        @time = time
        @period = period.to_i
      end

      def to_period_seconds
        period_time = time.split(":")
        period_time[0].to_i * 60 + period_time[1].to_i
      end

      def to_time_elapsed
        period_time = time.split(":")
        period_time[0].to_i * 60 + period_time[1].to_i + ((period - 1) * 1200)
      end

      alias to_sec to_period_seconds
      alias to_elapsed to_time_elapsed
    end
  end
end
