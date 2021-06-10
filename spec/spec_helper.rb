# frozen_string_literal: true

require "byebug"
require "webmock/rspec"
require "vcr"

require "bundler/setup"
require "ahl_scraper"

Dir[File.join(File.dirname(__FILE__), 'support/helpers/*.rb')].sort.each { |f| require f }

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/fixtures/cassettes"
  config.allow_http_connections_when_no_cassette = true
  config.configure_rspec_metadata!
  config.hook_into :webmock
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.include NextInstanceOf
end
