module AhlScraper
  module Seasons
    module Fetch
      module DivisionData
        module_function

        def fetch(season_id)
          url = "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=teams&groupTeamsBy=division&site_id=1&season=#{season_id}&key=50c2cd9b5e18e390&client_code=ahl&league_id=4&callback=json"
          JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)&.first&.dig(:sections)
        end
      end
    end
  end
end
