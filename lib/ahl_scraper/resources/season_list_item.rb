# frozen_string_literal: true

module AhlScraper
  class SeasonListItem < Resource
    def initialize(raw_data)
      @raw_data = raw_data
    end

    def id
      @id ||= @raw_data[:id].to_i
    end

    def name
      @name ||= @raw_data[:name]
    end

    def season_type
      case name
      when /Regular/
        :regular
      when /All-Star/
        :all_star
      when /Playoffs/
        :playoffs
      when /Exhibition/
        :exhibition
      end
    end
  end
end
