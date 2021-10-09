# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ahl_scraper.gemspec
gemspec

gem "json", "~> 2.5.1"
gem "nokogiri", "~> 1.12.4"
gem "rake", "~> 13.0.0"

group :development do
  gem "rubocop", "~> 0.89.0", require: false
  gem "rubocop-performance", "~> 1.8.1", require: false
  gem "solargraph", "~> 0.43.0"
end

group :development, :test do
  gem "byebug", "~> 11.1.3"
  gem "pry", "~> 0.13.1"
  gem "pry-byebug", "~> 3.9.0"
  gem "rspec", "~> 3.0"
  gem "vcr", "~> 6.0.0"
  gem "webmock", ">= 3.8.0"
end
