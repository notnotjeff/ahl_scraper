# frozen_string_literal: true

module AhlScraper
  class PlayoffBracket < Resource
    def initialize(bracket_data)
      @bracket_data = bracket_data
    end

    def teams
      @teams ||= @bracket_data[:teams].map { |_team_id, team_data| PlayoffBrackets::Team.new(team_data) }
    end

    def rounds
      @rounds ||= @bracket_data[:rounds].map { |round| PlayoffBrackets::Round.new(round, { bracket_data: @bracket_data }) }
    end

    def logo_url
      @logo_url ||= @bracket_data[:logo]
    end
  end
end
