# frozen_string_literal: true

module AhlScraper
  class PlayoffBracket < Resource
    def initialize(raw_data, opts = {})
      super(raw_data, opts)
    end

    def teams
      @teams ||= @raw_data[:teams].map { |_team_id, team_data| PlayoffBrackets::Team.new(team_data) }
    end

    def rounds
      @rounds ||= @raw_data[:rounds].map { |round| PlayoffBrackets::Round.new(round, { raw_data: @raw_data }) }
    end

    def logo_url
      @logo_url ||= @raw_data[:logo]
    end
  end
end
