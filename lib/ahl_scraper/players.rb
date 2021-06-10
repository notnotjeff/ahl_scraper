# frozen_string_literal: true

require "ahl_scraper/players/player_object"

module AhlScraper
  module Players
    class << self
      def retrieve(player_id)
        player_data = Fetch::PlayerData.new(player_id).call
        PlayerObject.new(player_data)
      end
    end
  end
end
