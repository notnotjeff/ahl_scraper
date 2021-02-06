# frozen_string_literal: true

RSpec.describe AhlScraper::Fetch::SeasonData do
  describe "#call" do
    it "returns season data from request" do
      season_data = described_class.new.call
      byebug
    end
  end
end
