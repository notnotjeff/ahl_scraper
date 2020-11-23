# frozen_string_literal: true

RSpec.describe AhlScraper::Games::GameObject do
  it "testing", :vcr do
    game = described_class.new(1_018_340)
    byebug
  end

  describe "#raw_data" do
    it "gets raw game data", :vcr do
      expect(described_class.new(1_018_340).raw_data.keys).to match_array(
        %i[details referees linesmen mostValuablePlayers hasShootout homeTeam visitingTeam periods penaltyShots featuredPlayer]
      )
    end
  end

  describe "#raw_event_data" do
    it "gets raw game event data", :vcr do
      expect(described_class.new(1_018_340).raw_event_data).not_to be_empty
    end
  end
end
