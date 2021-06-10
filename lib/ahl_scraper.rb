# frozen_string_literal: true

require "json"
require "nokogiri"
require "open-uri"
require "bigdecimal"

require "ahl_scraper/version"

require "ahl_scraper/resource"

require "ahl_scraper/games"
require "ahl_scraper/seasons"
require "ahl_scraper/teams"
require "ahl_scraper/players"
require "ahl_scraper/fetch"
require "ahl_scraper/errors"
require "ahl_scraper/helpers"
require "ahl_scraper/playoff_brackets"

module AhlScraper
  class Error < StandardError; end
end
