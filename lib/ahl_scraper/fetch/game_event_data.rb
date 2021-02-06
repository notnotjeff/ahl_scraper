# frozen_string_literal: true

module AhlScraper
  module Fetch
    class GameEventData
      def initialize(game_id)
        @game_id = game_id
      end

      def call
        JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)
      end

      private

      def url
        "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=gameCenterPlayByPlay&game_id=#{@game_id}&key=50c2cd9b5e18e390&client_code=ahl&lang=en&league_id=&callback=json" # rubocop:disable Layout/LineLength
      end
    end
  end
end
