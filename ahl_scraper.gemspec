# frozen_string_literal: true

require_relative "lib/ahl_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "ahl_scraper"
  spec.version       = AhlScraper::VERSION
  spec.authors       = ["jefftcraig"]
  spec.email         = ["jeffcraig35@gmail.com"]

  spec.summary       = "Scrape data from the AHL website"
  spec.description   = "Allows users to gather game, season, and player data from the AHL website"
  spec.homepage      = "http://www.ahltracker.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = "https://github.com/notnotjeff/ahl_scraper"
  spec.metadata["source_code_uri"] = "https://github.com/notnotjeff/ahl_scraper"
  spec.metadata["changelog_uri"] = "https://github.com/notnotjeff/ahl_scraper"

  spec.add_dependency "json", "~> 2.5.1"
  spec.add_dependency "nokogiri", "~> 1.12.4"
  spec.add_dependency "rake", "~> 13.0.0"

  spec.add_development_dependency "byebug", "~> 11.1.3"
  spec.add_development_dependency "pry", "~> 0.13.1"
  spec.add_development_dependency "pry-byebug", "~> 3.9.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.89.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.8.1"
  spec.add_development_dependency "solargraph", "~> 0.43.0"
  spec.add_development_dependency "vcr", "~> 6.0.0"
  spec.add_development_dependency "webmock", ">= 3.8.0"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
