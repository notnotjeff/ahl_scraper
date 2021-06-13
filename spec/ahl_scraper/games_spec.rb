# frozen_string_literal: true

RSpec.describe AhlScraper::Games do
  describe ".retrieve" do
    it "returns game object", :vcr do
      game = described_class.retrieve(1_022_057)

      expect(game.class).to eq(AhlScraper::Game)
    end

    context "when season_type provided" do
      it "does not make season type request", :vcr do
        expect(AhlScraper::SeasonTypeFetcher).not_to receive(:new)
        described_class.retrieve(1_022_057, :regular)
      end
    end
  end

  describe ".list" do
    it "returns array of game_ids for season", :vcr do
      game_ids = described_class.list(65)

      expect(game_ids).to all(be_a(AhlScraper::GameListItem))
    end
  end
end
