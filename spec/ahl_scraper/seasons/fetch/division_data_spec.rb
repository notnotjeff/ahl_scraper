# frozen_string_literal: true

RSpec.describe AhlScraper::Seasons::Fetch::DivisionData do
  describe "#fetch" do
    it "returns division data", :vcr do
      data = described_class.fetch(57)

      expect(data.length).to eq(4)
    end
  end
end
