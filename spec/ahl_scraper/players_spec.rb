# frozen_string_literal: true

RSpec.describe AhlScraper::Players do
  let(:player_id) { 7446 }

  describe ".retrieve" do
    it "returns array of PlayerObjects for a team season", :vcr do
      player = described_class.retrieve(player_id)

      expect(player).to be_a(AhlScraper::Player)
    end
  end
end
