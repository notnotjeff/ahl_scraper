# frozen_string_literal: true

RSpec.describe AhlScraper::Teams do
  let(:season_id) { 65 }

  describe ".list" do
    it "returns array of TeamObjects for season", :vcr do
      teams = described_class.list(season_id)

      expect(teams).to all(be_a(AhlScraper::Teams::TeamObject))
    end
  end
end
