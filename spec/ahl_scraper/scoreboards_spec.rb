# frozen_string_literal: true

RSpec.describe AhlScraper::Scoreboards do
  describe ".list" do
    let(:start_date) { Date.parse("2021-10-25") }
    let(:end_date) { Date.parse("2021-11-05") }

    before do
      allow(Date).to receive(:today).and_return(Date.parse("2021-10-30"))
    end

    it "returns array of RosterPlayers for season", :vcr do
      scoreboards = described_class.list(start_date, end_date)

      expect(scoreboards).to all(be_a(AhlScraper::Scoreboard))
    end
  end
end
