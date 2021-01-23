# frozen_string_literal: true

RSpec.describe AhlScraper::Seasons::Fetch::StartAndEndDays do
  let(:covid_season) { { id: 68, name: "2020-21 Regular Season", start_month: 2, end_month: 6 } }
  let(:regular) { { id: 57, name: "2017-18 Regular Season", start_month: 10, end_month: 4 } }
  let(:playoffs) { { id: 64, name: "2019 Calder Cup Playoffs", start_month: 4, end_month: 6 } }
  let(:exhibition) { { id: 58, name: "2017-18 Exhibition", start_month: 9, end_month: 10 } }
  let(:all_star_game) { { id: 67, name: "2020 All-Star Challenge", start_month: 2, end_month: 2 } }

  describe "#call" do
    context "when regular season" do
      it "returns start and end dates for season", :vcr do
        start_date, end_date = described_class.fetch(regular[:id], regular[:start_month], regular[:end_month])

        expect(start_date).to eq("Fri, Oct 6")
        expect(end_date).to eq("Sun, Apr 15")
      end
    end

    context "when playoffs" do
      it "returns start and end dates for season", :vcr do
        start_date, end_date = described_class.fetch(playoffs[:id], playoffs[:start_month], playoffs[:end_month])

        expect(start_date).to eq("Wed, Apr 17")
        expect(end_date).to eq("Sat, Jun 8")
      end
    end

    context "when covid season" do
      it "returns start and end dates for season" do
        start_date, end_date = described_class.fetch(covid_season[:id], covid_season[:start_month], covid_season[:end_month])

        expect(start_date).to eq("Fri, Feb 5")
        expect(end_date).to eq(nil)
      end
    end

    context "when exhibition season" do
      it "returns nil for start and end dates" do
        start_date, end_date = described_class.fetch(exhibition[:id], exhibition[:start_month], exhibition[:end_month])

        expect(start_date).to eq(nil)
        expect(end_date).to eq(nil)
      end
    end

    context "when all star game season" do
      it "returns nil for start and end dates" do
        start_date, end_date = described_class.fetch(all_star_game[:id], all_star_game[:start_month], all_star_game[:end_month])

        expect(start_date).to eq(nil)
        expect(end_date).to eq(nil)
      end
    end
  end
end
