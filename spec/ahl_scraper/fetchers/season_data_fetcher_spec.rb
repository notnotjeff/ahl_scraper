# frozen_string_literal: true

RSpec.describe AhlScraper::SeasonDataFetcher do
  describe "#call" do
    it "returns season data from request", :vcr, :aggregate_failures do
      season_data = described_class.new.call

      expect(season_data).to be_a(Array)
      expect(season_data.length).to be_positive
    end
  end
end
