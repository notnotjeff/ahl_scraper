# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets do
  let(:season_id) { 64 }

  describe ".retrieve" do
    it "returns playoff bracket for season", :vcr do
      bracket = described_class.retrieve(season_id)

      expect(bracket.teams).to all(be_a(AhlScraper::PlayoffBrackets::Team))
      expect(bracket.rounds).to all(be_a(AhlScraper::PlayoffBrackets::Round))
      expect(bracket.logo_url).to be_a(String)
    end
  end
end
