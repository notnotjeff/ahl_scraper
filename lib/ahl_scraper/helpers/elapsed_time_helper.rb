# frozen_string_literal: true

module AhlScraper
  class ElapsedTimeHelper
    attr_reader :time

    def initialize(time)
      @time = time.to_i
    end

    def to_minutes
      "#{time / 60}:#{(time % 60).to_s.rjust(2, '0')}"
    end

    def to_minutes_with_period
      period_elapsed = time % 1200

      ["#{period_elapsed / 60}:#{period_elapsed % 60}", (time / 1200) + 1]
    end

    alias to_min to_minutes
    alias to_min_with_per to_minutes_with_period
  end
end
