# frozen_string_literal: true

require "date"

module AhlScraper
  module Helpers
    class Birthdate
      attr_reader :birthdate

      def initialize(birthdate)
        @birthdate = Date.parse(birthdate)
      end

      def draft_year
        return (birthdate + (19 * 365)).year if (birthdate.month == 9 && birthdate.day > 15) || birthdate.month > 9

        (birthdate + (18 * 365)).year
      end

      def current_age
        now = Time.now.utc.to_date
        now.year - birthdate.year - (now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day) ? 0 : 1)
      end
    end
  end
end
