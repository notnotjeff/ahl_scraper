# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ahl_scraper.gemspec
gemspec

gem "json"
gem "nokogiri"
gem "rake", "~> 12.0"

group :development do
  gem "rubocop", "~> 0.89.0", require: false
  gem "rubocop-performance", "~> 1.8.1", require: false
  gem "solargraph"
end

group :development, :test do
  gem "byebug"
  gem "pry"
  gem "pry-byebug"
  gem "rspec", "~> 3.0"
  gem "vcr"
  gem "webmock", ">= 3.8.0"
end
