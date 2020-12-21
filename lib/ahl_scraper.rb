# frozen_string_literal: true

require "json"
require "nokogiri"
require "open-uri"
require "time"

require "ahl_scraper/version"

# Scraper Modules
require "ahl_scraper/games"

module AhlScraper
  class Error < StandardError; end
end
