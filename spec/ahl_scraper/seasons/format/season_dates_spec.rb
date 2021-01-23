# frozen_string_literal: true

RSpec.describe AhlScraper::Seasons::Format::SeasonDates do
  let(:covid_season) { { id: 68, name: "2020-21 Regular Season", season_type: :regular } }
  let(:regular) { { id: 57, name: "2017-18 Regular Season", season_type: :regular } }
  let(:playoffs) { { id: 64, name: "2019 Calder Cup Playoffs", season_type: :playoffs } }
  let(:exhibition) { { id: 58, name: "2017-18 Exhibition", season_type: :exhibition } }
  let(:all_star_game) { { id: 67, name: "2020 All-Star Challenge", season_type: :all_star_game } }

  describe "#call" do
    context "when regular season" do
      it "returns start and end dates for season", :vcr do
        start_date, end_date = described_class.new(regular[:id], regular[:season_type], regular[:name]).call

        expect(start_date).to eq("Fri, Oct 6 2017")
        expect(end_date).to eq("Sun, Apr 15 2018")
      end
    end

    context "when playoffs" do
      it "returns start and end dates for season", :vcr do
        start_date, end_date = described_class.new(playoffs[:id], playoffs[:season_type], playoffs[:name]).call

        expect(start_date).to eq("Wed, Apr 17 2019")
        expect(end_date).to eq("Sat, Jun 8 2019")
      end
    end

    context "when covid season" do
      it "returns start and end dates for season" do
        start_date, end_date = described_class.new(covid_season[:id], covid_season[:season_type], covid_season[:name]).call

        expect(start_date).to eq("Mon, Feb 1 2021")
        expect(end_date).to eq("Sat, Jun 8 2021")
      end
    end

    context "when exhibition season" do
      it "returns nil for start and end dates" do
        start_date, end_date = described_class.new(exhibition[:id], exhibition[:season_type], exhibition[:name]).call

        expect(start_date).to eq(nil)
        expect(end_date).to eq(nil)
      end
    end

    context "when all star game season" do
      it "returns nil for start and end dates" do
        start_date, end_date = described_class.new(all_star_game[:id], all_star_game[:season_type], all_star_game[:name]).call

        expect(start_date).to eq(nil)
        expect(end_date).to eq(nil)
      end
    end
  end
end
