# frozen_string_literal: true

RSpec.describe AhlScraper::Scoreboards::DataFetcher do
  describe "#call" do
    let(:start_date) { Date.parse("2021-10-25") }
    let(:end_date) { Date.parse("2021-11-05") }

    before do
      allow(Date).to receive(:today).and_return(Date.parse("2021-10-30"))
    end

    it "fetches scoreboard data for date range", :vcr do
      games = described_class.new(start_date: start_date, end_date: end_date).call

      games.each do |_game|
        expect(Date.parse(card[:Date])).to be_between(start_date, end_date)
      end
    end
  end
end
