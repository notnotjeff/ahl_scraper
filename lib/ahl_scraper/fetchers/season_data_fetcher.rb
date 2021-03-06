# frozen_string_literal: true

module AhlScraper
  class SeasonDataFetcher
    def call
      JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)&.dig(:seasons)
    end

    private

    def url
      "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=bootstrap&season=latest&pageName=schedule&key=50c2cd9b5e18e390&client_code=ahl&site_id=1&league_id=&league_code=&lang=en&callback=json" # rubocop:disable Layout/LineLength
    end
  end
end
