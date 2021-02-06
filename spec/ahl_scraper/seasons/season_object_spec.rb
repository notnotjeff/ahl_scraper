# frozen_string_literal: true

RSpec.describe AhlScraper::Seasons::SeasonObject do
  let(:raw_data) do
    { "id": "57", "name": "2017-18 Regular Season", "default_sort": "" }
  end

  it "converts raw data into Season record", :vcr do
    season = described_class.new(raw_data)
    season.teams

    expect(season.id).to eq(57)
    expect(season.name).to eq("2017-18 Regular Season")
    expect(season.abbreviation).to eq("17-18")
    expect(season.season_type).to eq(:regular)
    expect(season.start_year).to eq(2017)
    expect(season.end_year).to eq(2018)
    expect(season.start_date).to eq("Fri, Oct 6 2017")
    expect(season.end_date).to eq("Sun, Apr 15 2018")
    expect(season.teams.length).to eq(30)
    expect(season.divisions).to match_array(["Atlantic Division", "North Division", "Central Division", "Pacific Division"])
  end

  context "when playoffs" do
    let(:raw_data) do
      { "id": "64", "name": "2019 Calder Cup Playoffs", "default_sort": "" }
    end

    it "converts raw data into Season record", :vcr do
      season = described_class.new(raw_data)

      expect(season.id).to eq(64)
      expect(season.name).to eq("2019 Calder Cup Playoffs")
      expect(season.abbreviation).to eq("19PO")
      expect(season.season_type).to eq(:playoffs)
      expect(season.start_year).to eq(2019)
      expect(season.end_year).to eq(2019)
      expect(season.start_date).to eq("Wed, Apr 17 2019")
      expect(season.end_date).to eq("Sat, Jun 8 2019")
      expect(season.teams.length).to eq(16)
      expect(season.divisions).to match_array(["Atlantic Division", "North Division", "Central Division", "Pacific Division"])
    end
  end

  context "when all star" do
    let(:raw_data) do
      { "id": "67", "name": "2020 All-Star Challenge", "default_sort": "" }
    end

    it "converts raw data into Season record", :vcr do
      season = described_class.new(raw_data)

      expect(season.id).to eq(67)
      expect(season.name).to eq("2020 All-Star Challenge")
      expect(season.abbreviation).to eq("20ASG")
      expect(season.season_type).to eq(:all_star_game)
      expect(season.start_year).to eq(2020)
      expect(season.end_year).to eq(2020)
      expect(season.start_date).to eq(nil)
      expect(season.end_date).to eq(nil)
      expect(season.teams.length).to eq(0)
      expect(season.divisions).to match_array([])
    end
  end

  context "when exhibition" do
    let(:raw_data) do
      { "id": "58", "name": "2017-18 Exhibition", "default_sort": "" }
    end

    it "converts raw data into Season record", :vcr do
      season = described_class.new(raw_data)

      expect(season.id).to eq(58)
      expect(season.name).to eq("2017-18 Exhibition")
      expect(season.abbreviation).to eq("17-18EX")
      expect(season.season_type).to eq(:exhibition)
      expect(season.start_year).to eq(2017)
      expect(season.end_year).to eq(2018)
      expect(season.start_date).to eq(nil)
      expect(season.end_date).to eq(nil)
      expect(season.teams.length).to eq(0)
      expect(season.divisions).to match_array([])
    end
  end
end
