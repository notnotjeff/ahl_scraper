# frozen_string_literal: true

require "json"
require "nokogiri"
require "open-uri"
require "bigdecimal"

require "ahl_scraper/version"

require "ahl_scraper/fetchers/division_data_fetcher"
require "ahl_scraper/fetchers/game_data_fetcher"
require "ahl_scraper/fetchers/game_event_data_fetcher"
require "ahl_scraper/fetchers/player_data_fetcher"
require "ahl_scraper/fetchers/playoff_bracket_data_fetcher"
require "ahl_scraper/fetchers/season_data_fetcher"
require "ahl_scraper/fetchers/season_end_date_fetcher"
require "ahl_scraper/fetchers/season_game_ids_fetcher"
require "ahl_scraper/fetchers/season_start_date_fetcher"
require "ahl_scraper/fetchers/season_type_fetcher"
require "ahl_scraper/fetchers/team_data_fetcher"
require "ahl_scraper/fetchers/team_roster_data_fetcher"

require "ahl_scraper/helpers/birthdate_helper"
require "ahl_scraper/helpers/elapsed_time_helper"
require "ahl_scraper/helpers/ice_time_helper"
require "ahl_scraper/helpers/parameterize_helper"
require "ahl_scraper/helpers/period_time_helper"
require "ahl_scraper/helpers/season_dates_helper"

require "ahl_scraper/resource"

require "ahl_scraper/resources/game"
require "ahl_scraper/resources/playoff_bracket"
require "ahl_scraper/resources/season"
require "ahl_scraper/resources/team_list_item"
require "ahl_scraper/resources/team_game_list_item"
require "ahl_scraper/resources/game_list_item"
require "ahl_scraper/resources/goalie_game_list_item"
require "ahl_scraper/resources/season_list_item"
require "ahl_scraper/resources/skater_game_list_item"
require "ahl_scraper/resources/roster_player"
require "ahl_scraper/resources/player"

require "ahl_scraper/games"
require "ahl_scraper/seasons"
require "ahl_scraper/team_games"
require "ahl_scraper/teams"
require "ahl_scraper/player_games"
require "ahl_scraper/players"
require "ahl_scraper/playoff_brackets"
require "ahl_scraper/roster_players"

module AhlScraper
  class Error < StandardError; end
end
