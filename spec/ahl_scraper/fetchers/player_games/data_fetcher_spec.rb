# frozen_string_literal: true

RSpec.describe AhlScraper::PlayerGames::DataFetcher do
  describe "#call" do
    context "when player is a skater" do
      let(:player_id) { 304 }
      let(:season_id) { 1 }

      it "fetches game data for skater season", :vcr do
        game_data = described_class.new(player_id, season_id).call

        expect(game_data.length).to eq(77)
        expect(game_data[0].keys).to match_array(%i[row prop position])
      end
    end

    context "when player is a goalie" do
      let(:player_id) { 368 }
      let(:season_id) { 1 }

      it "fetches game data for goalie season", :vcr do
        game_data = described_class.new(player_id, season_id).call

        expect(game_data.length).to eq(6)
        expect(game_data[0].keys).to match_array(%i[row prop position])
      end
    end
  end
end
