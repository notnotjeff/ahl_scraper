# frozen_string_literal: true

module AhlScraper
  class GameDataFetcher
    BROKEN_GAMES = [1_018_774, 1_001_050, 1_020_527].freeze

    def initialize(game_id)
      @game_id = game_id
    end

    def call
      return fixed_game if BROKEN_GAMES.include? @game_id

      JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)
    end

    private

    def fixed_game
      path = File.join(File.dirname(__FILE__), "../fixed_games/#{@game_id}.json")
      file = File.read(path)
      JSON.parse(file, symbolize_names: true)
    end

    def url
      "http://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=gameSummary&game_id=#{@game_id}&key=50c2cd9b5e18e390&site_id=1&client_code=ahl&lang=en&league_id=&callback=json" # rubocop:disable Layout/LineLength
    end
  end
end
