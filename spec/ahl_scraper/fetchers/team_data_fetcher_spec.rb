# frozen_string_literal: true

RSpec.describe AhlScraper::TeamDataFetcher do
  describe "#call" do
    it "returns team data for specific season from request", :vcr do
      team_data = described_class.new(65).call

      expect(team_data).to all(be_a(Object))
    end
  end
end
