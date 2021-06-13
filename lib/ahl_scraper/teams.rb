# frozen_string_literal: true

module AhlScraper
  module Teams
    class << self
      def list(season_id)
        TeamDataFetcher.new(season_id).call&.map { |team| TeamListItem.new(team, season_id) }
      end
    end
  end
end
