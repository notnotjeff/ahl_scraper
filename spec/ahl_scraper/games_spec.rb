# frozen_string_literal: true

RSpec.describe AhlScraper::Games do
  describe ".retrieve" do
    it "returns game object", :vcr do
      game = described_class.retrieve(1_022_057)

      expect(game.class).to eq(AhlScraper::Games::GameObject)
    end

    context "when season_type provided" do
      it "does not make season type request", :vcr do
        expect(AhlScraper::Fetch::SeasonType).not_to receive(:new)
        described_class.retrieve(1_022_057, :regular)
      end
    end
  end
end
