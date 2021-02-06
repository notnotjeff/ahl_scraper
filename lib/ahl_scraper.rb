# frozen_string_literal: true

require "json"
require "nokogiri"
require "open-uri"

require "ahl_scraper/version"

# Format
require "ahl_scraper/format/teams"

# Scraper Modules
require "ahl_scraper/games"
require "ahl_scraper/seasons"
require "ahl_scraper/fetch"
require "ahl_scraper/helpers"
require "ahl_scraper/format"

module AhlScraper
  class Error < StandardError; end
end
