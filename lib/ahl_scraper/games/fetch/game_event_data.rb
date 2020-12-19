# frozen_string_literal: true

module AhlScraper
  module Games
    module Fetch
      module GameEventData
        module_function

        def fetch(game_id)
          event_url = "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=gameCenterPlayByPlay&game_id=#{game_id}&key=50c2cd9b5e18e390&client_code=ahl&lang=en&league_id=&callback=json" # rubocop:disable Layout/LineLength
          JSON.parse(Nokogiri::HTML(URI.parse(event_url).open).text[5..-2], symbolize_names: true)
        end
      end
    end
  end
end
