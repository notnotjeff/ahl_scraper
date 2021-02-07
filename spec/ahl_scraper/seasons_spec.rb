# frozen_string_literal: true

RSpec.describe AhlScraper::Seasons do
  describe ".list" do
    it "returns raw season data as an Object", :vcr do
      seasons = described_class.list

      expect(seasons).to all(be_a(Object))
    end
  end

  describe ".retrieve" do
    context "with single season" do
      it "returns season object", :vcr do
        season = described_class.retrieve(61)

        expect(season.class).to eq(AhlScraper::Seasons::SeasonObject)
      end
    end

    context "with multiple seasons" do
      it "returns an array with multiple season objects", :vcr do
        season_ids = [61, 57]
        seasons = described_class.retrieve(season_ids)

        expect(seasons).to all(be_a(AhlScraper::Seasons::SeasonObject))
        expect(seasons.length).to eq(season_ids.length)
      end
    end
  end

  describe ".retrieve_all" do
    it "returns all seasons as season objects", :vcr do
      raw_seasons = described_class.list
      seasons = described_class.retrieve_all

      expect(seasons).to all(be_a(AhlScraper::Seasons::SeasonObject))
      expect(seasons.length).to eq(raw_seasons.length)
    end
  end
end
