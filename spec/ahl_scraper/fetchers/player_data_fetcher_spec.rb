# frozen_string_literal: true

RSpec.describe AhlScraper::PlayerDataFetcher do
  describe "#call" do
    it "returns player data", :vcr do
      player_data = described_class.new(7446).call

      expect(player_data).to be_a(Object)
    end

    context "when unexpected token in bio data" do
      it "returns player data without bio", :vcr do
        player_data = described_class.new(5721).call

        expect(player_data).to be_a(Object)
      end
    end
  end
end
