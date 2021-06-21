# frozen_string_literal: true

RSpec.describe AhlScraper::TeamGames::DataFetcher do
  describe "#call" do
    let(:team_id) { 313 }
    let(:season_id) { 68 }

    it "fetches game data for team season", :vcr do
      game_data = described_class.new(team_id, season_id).call

      expect(game_data.length).to eq(32)
    end
  end
end
