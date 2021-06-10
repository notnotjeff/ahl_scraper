# frozen_string_literal: true

RSpec.describe AhlScraper::Teams do
  let(:season_id) { 65 }

  describe ".list" do
    it "returns array of TeamObjects for season", :vcr do
      teams = described_class.list(season_id)

      expect(teams).to all(be_a(AhlScraper::Teams::TeamObject))
    end
  end

  describe ".retrieve" do
    let(:team_id) { 335 }
    let(:season_id) { 61 }

    it "returns array of Players for season", :vcr do
      teams = described_class.retrieve(team_id, season_id)

      expect(teams).to all(be_a(AhlScraper::Teams::Player))
    end
  end
end
