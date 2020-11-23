require_relative 'lib/ahl_scraper/version'

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

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = "http://www.ahltracker.com"
  spec.metadata["source_code_uri"] = "http://www.ahltracker.com" # change to github url later
  spec.metadata["changelog_uri"] = "http://www.ahltracker.com" # change to changelod.md later
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
