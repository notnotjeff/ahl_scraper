# frozen_string_literal: true

require "date"

module AhlScraper
  class BirthdateHelper
    attr_reader :birthdate

    def initialize(birthdate)
      @birthdate = Date.parse(birthdate)
    end

    def draft_year
      return (birthdate + (19 * 365)).year if (birthdate.month == 9 && birthdate.day > 15) || birthdate.month > 9

      (birthdate + (18 * 365)).year
    end

    def current_age(round: 2)
      ((Time.now.utc.to_datetime - birthdate.to_datetime).to_i / BigDecimal("365")).round(round)
    end

    def age_on_date(date, round: 2)
      ((Date.parse(date).to_datetime - birthdate.to_datetime).to_i / BigDecimal("365")).round(round)
    end
  end
end
