# frozen_string_literal: true

RSpec.describe AhlScraper::Fetch::SeasonGameIds do
  describe "#call" do
    it "returns game ids for season", :vcr do
      game_ids = described_class.new(65).call

      expect(game_ids).to all(be_a(Integer))
    end
  end
end
