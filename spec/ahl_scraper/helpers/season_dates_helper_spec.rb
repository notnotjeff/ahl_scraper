# frozen_string_literal: true

RSpec.describe AhlScraper::SeasonDatesHelper do
  it "has DATE_EXCEPTIONS constant" do
    expect(described_class::DATE_EXCEPTIONS).to be_a(Hash)
  end

  it "has SEASON_MONTH_KEY constant" do
    expect(described_class::SEASON_MONTH_KEY).to be_a(Hash)
  end
end
