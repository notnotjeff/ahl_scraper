# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBracketDataFetcher do
  describe "#call", :vcr do
    it "returns playoff bracket JSON" do
      bracket = described_class.new(60).call

      expect(bracket.keys).to match_array(%i[teams rounds logo])
    end
  end
end
