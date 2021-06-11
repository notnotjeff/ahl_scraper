# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Period do
  let(:raw_data) do
    {
      info: { id: "1", shortName: "1", longName: "1st" },
      stats: { homeGoals: "0", homeShots: "10", visitingGoals: "1", visitingShots: "6" },
    }
  end

  it "converts raw data into Period record" do
    period = described_class.new(raw_data)

    expect(period.number).to eq(raw_data[:info][:id].to_i)
    expect(period.name).to eq(raw_data[:info][:longName])
    expect(period.home_goals).to eq(raw_data[:stats][:homeGoals])
    expect(period.home_sog).to eq(raw_data[:stats][:homeShots])
    expect(period.away_goals).to eq(raw_data[:stats][:visitingGoals])
    expect(period.away_sog).to eq(raw_data[:stats][:visitingShots])
  end
end
