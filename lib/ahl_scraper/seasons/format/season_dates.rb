# frozen_string_literal: true

module AhlScraper
  module Seasons
    module Format
      class SeasonDates
        # include Fetch::StartAndEndDays

        DATE_EXCEPTIONS = {
          68 => { start_date: "Mon, Feb 1 2021", end_date: "Sat, Jun 8 2021" },
        }.freeze

        SEASON_START_KEY = {
          regular: { start_month: "10", end_month: "4" },
          playoffs: { start_month: "4", end_month: "6" },
        }.freeze

        attr_reader :season_id, :season_type, :name

        def initialize(season_id, season_type, name)
          @season_id = season_id
          @season_type = season_type
          @name = name
        end

        def call
          return [DATE_EXCEPTIONS[season_id][:start_date], DATE_EXCEPTIONS[season_id][:end_date]] if DATE_EXCEPTIONS.keys.include? season_id

          return [nil, nil] if %i[all_star_game exhibition].include? season_type

          @start_day = "asdf"
          @end_day = "fdsa" # Fetch::StartAndEndDays.fetch(season_id, SEASON_START_KEY[season_type][:start_month], SEASON_START_KEY[season_type][:end_month])
          [start_date, end_date]
        end

        private

        def start_date
          @start_day ? "#{@start_day} #{start_year}" : nil
        end

        def start_year
          @start_year ||=
            case season_type
            when :regular
              name[/(.*?)\-/].to_i
            when :playoffs, :all_star_game
              name[/(.*?) /].to_i
            else
              0
            end
        end

        def end_date
          @end_day ? "#{@end_day} #{end_year}" : nil
        end

        def end_year
          @end_year ||=
            case season_type
            when :regular
              start_year + 1
            when :playoffs, :all_star_game
              start_year
            end
        end
      end
    end
  end
end
