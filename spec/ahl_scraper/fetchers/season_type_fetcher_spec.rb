# frozen_string_literal: true

RSpec.describe AhlScraper::SeasonTypeFetcher do
  describe "#fetch", :vcr do
    context "when game is regular season" do
      it "returns :regular" do
        season_type = described_class.new(61).call
        expect(season_type).to eq(:regular)
      end
    end

    context "when game is playoffs" do
      it "returns :playoffs" do
        season_type = described_class.new(64).call
        expect(season_type).to eq(:playoffs)
      end
    end

    context "when all-star game" do
      it "returns :all_star" do
        season_type = described_class.new(63).call
        expect(season_type).to eq(:all_star)
      end
    end

    context "when game is exhibition" do
      it "returns :exhibition" do
        season_type = described_class.new(45).call
        expect(season_type).to eq(:exhibition)
      end
    end
  end
end
