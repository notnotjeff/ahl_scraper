# frozen_string_literal: true

module AhlScraper
  module Helpers
    class SeasonDates
      DATE_EXCEPTIONS = {
        68 => { start_date: "Mon, Feb 1 2021", end_date: "Sat, Jun 8 2021" },
      }.freeze

      SEASON_MONTH_KEY = {
        regular: { start_month: "10", end_month: "4" },
        playoffs: { start_month: "4", end_month: "6" },
      }.freeze
    end
  end
end
