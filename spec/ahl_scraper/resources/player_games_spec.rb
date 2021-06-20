# frozen_string_literal: true

RSpec.describe AhlScraper::PlayerGames do
  describe ".list" do
    context "when skater" do
      let(:player_id) { 304 }
      let(:season_id) { 1 }

      it "returns skater game objects", :vcr do
        skater_games = described_class.list(player_id, season_id)

        expect(skater_games).to all(be_a(AhlScraper::SkaterGameListItem))
      end
    end

    context "when goalie" do
      let(:player_id) { 368 }
      let(:season_id) { 1 }

      it "returns goalie game objects", :vcr do
        goalie_games = described_class.list(player_id, season_id)

        expect(goalie_games).to all(be_a(AhlScraper::GoalieGameListItem))
      end
    end
  end
end
