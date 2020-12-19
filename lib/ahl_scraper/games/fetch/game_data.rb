# frozen_string_literal: true

module AhlScraper
  module Games
    module Fetch
      module GameData
        module_function

        def fetch(game_id)
          game_url = "http://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=gameSummary&game_id=#{game_id}&key=50c2cd9b5e18e390&site_id=1&client_code=ahl&lang=en&league_id=&callback=json" # rubocop:disable Layout/LineLength
          JSON.parse(Nokogiri::HTML(URI.parse(game_url).open).text[5..-2], symbolize_names: true)
        end
      end
    end
  end
end
