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
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = "https://github.com/notnotjeff/ahl_scraper"
  spec.metadata["source_code_uri"] = "https://github.com/notnotjeff/ahl_scraper"
  spec.metadata["changelog_uri"] = "https://github.com/notnotjeff/ahl_scraper"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
