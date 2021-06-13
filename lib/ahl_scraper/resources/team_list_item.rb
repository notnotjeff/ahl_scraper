# frozen_string_literal: true

module AhlScraper
  class TeamListItem < Resource
    attr_reader :season_id

    def initialize(raw_data, season_id)
      @raw_data = raw_data
      @season_id = season_id
    end

    def name
      @name ||= @raw_data[:row][:name]
    end

    def id
      @id ||= @raw_data[:prop][:team_code][:teamLink].to_i
    end
  end
end
