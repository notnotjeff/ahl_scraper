# frozen_string_literal: true

RSpec.describe AhlScraper::Fetch::SeasonData do
  describe "#call" do
    it "returns season data from request", :vcr do
      season_data = described_class.new.call

      expect(season_data).to all(be_a(AhlScraper::Fetch::Season))
    end
  end
end
