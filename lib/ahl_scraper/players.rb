# frozen_string_literal: true

module AhlScraper
  module Players
    class << self
      def retrieve(player_id)
        player_data = PlayerDataFetcher.new(player_id).call
        Player.new(player_data)
      end
    end
  end
end
