# frozen_string_literal: true

RSpec.describe AhlScraper::Games do
  describe ".retrieve" do
    let(:game_id) { 1_022_057 }

    it "returns game object", :vcr do
      game = described_class.retrieve(game_id)

      expect(game.class).to eq(AhlScraper::Game)
    end

    context "when season_type provided" do
      it "does not make season type request", :vcr do
        expect(AhlScraper::SeasonTypeFetcher).not_to receive(:new)
        described_class.retrieve(game_id, :regular)
      end
    end
  end

  describe ".list" do
    let(:season_id) { 65 }

    it "returns array of game_ids for season", :vcr do
      game_ids = described_class.list(season_id)

      expect(game_ids).to all(be_a(AhlScraper::GameListItem))
    end
  end
end
