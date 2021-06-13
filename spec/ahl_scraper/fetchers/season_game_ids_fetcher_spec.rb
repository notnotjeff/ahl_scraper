# frozen_string_literal: true

RSpec.describe AhlScraper::SeasonGameIdsFetcher do
  describe "#call" do
    it "returns game ids for season", :vcr, :aggregate_failures do
      game_data = described_class.new(65).call

      expect(game_data.length).to be_positive
      expect(game_data).to be_a(Array)
    end
  end
end
