# frozen_string_literal: true

RSpec.describe AhlScraper::Fetch::TeamRosterData do
  let(:team_id) { 335 }
  let(:season_id) { 65 }

  describe "#call" do
    it "returns team roster data for specific team and season from request", :vcr do
      roster_data = described_class.new(team_id, season_id).call

      expect(roster_data).to all(be_a(Object))
    end
  end
end
