# frozen_string_literal: true

RSpec.describe AhlScraper::RosterPlayers do
  describe ".retrieve_all" do
    let(:team_id) { 335 }
    let(:season_id) { 61 }

    it "returns array of RosterPlayers for season", :vcr do
      teams = described_class.retrieve_all(team_id, season_id)

      expect(teams).to all(be_a(AhlScraper::RosterPlayer))
    end
  end
end
