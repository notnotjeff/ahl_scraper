# frozen_string_literal: true

RSpec.describe AhlScraper::Games do
  describe ".retrieve" do
    it "returns game object" do
      # Revert to GID: 1_022_057
      game = described_class.retrieve(1_019_623)
      byebug
      game.values

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
