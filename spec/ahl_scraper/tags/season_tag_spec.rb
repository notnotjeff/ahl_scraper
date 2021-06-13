# frozen_string_literal: true

RSpec.describe AhlScraper::SeasonTag do
  let(:season_data) { { id: "72", name: "2021 Playoffs", default_sort: "" } }

  it "creates valid SeasonTag object" do
    season_tag = described_class.new(season_data)

    expect(season_tag.id).to eq(72)
    expect(season_tag.name).to eq("2021 Playoffs")
    expect(season_tag.season_type).to eq(:playoffs)
  end
end
