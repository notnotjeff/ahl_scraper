# frozen_string_literal: true

require "json"
require "nokogiri"
require "open-uri"

require "ahl_scraper/version"

# Concerns
require "ahl_scraper/helpers/parameterize"

# Scraper Modules
require "ahl_scraper/games"
require "ahl_scraper/seasons"
require "ahl_scraper/fetch"

module AhlScraper
  class Error < StandardError; end
end
