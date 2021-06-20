# frozen_string_literal: true

RSpec.describe AhlScraper::GameDataFetcher do
  describe "#call" do
    it "gets game JSON data", :vcr do
      json = described_class.new(1_018_544).call

      expect(json.keys).to match_array(%i[details featuredPlayer hasShootout homeTeam linesmen mostValuablePlayers penaltyShots periods referees visitingTeam])
    end

    context "when game is broken" do
      it "uses fixed JSON file", :assert_failures do
        expect(URI).not_to receive(:parse)

        json = described_class.new(1_018_774).call

        expect(json.keys).to match_array(%i[details featuredPlayer hasShootout homeTeam linesmen mostValuablePlayers penaltyShots periods referees visitingTeam])
      end
    end
  end
end
