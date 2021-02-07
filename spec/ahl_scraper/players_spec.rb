# frozen_string_literal: true

RSpec.describe AhlScraper::Players do
  let(:team_id) { 335 }
  let(:season_id) { 65 }

  describe ".retrieve" do
    it "returns array of PlayerObjects for a team season", :vcr do
      players = described_class.retrieve(team_id, season_id)

      expect(players).to all(be_a(AhlScraper::Players::PlayerObject))
    end
  end
end
