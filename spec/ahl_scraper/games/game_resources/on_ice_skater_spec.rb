# frozen_string_literal: true

RSpec.describe AhlScraper::Games::OnIceSkater do
  let(:raw_data) { { id: 6725, firstName: "Ryan", lastName: "Collins", jerseyNumber: 6, position: "D", birthDate: "" } }

  it "converts raw data to On Ice Skater record" do
    scoring_team = true
    on_ice_skater = described_class.new(raw_data, { scoring_team: scoring_team })

    expect(on_ice_skater.id).to eq(raw_data[:id])
    expect(on_ice_skater.first_name).to eq(raw_data[:firstName])
    expect(on_ice_skater.last_name).to eq(raw_data[:lastName])
    expect(on_ice_skater.jersey_number).to eq(raw_data[:jerseyNumber])
    expect(on_ice_skater.position).to eq(raw_data[:position])
    expect(on_ice_skater.scoring_team?).to eq(scoring_team)
  end
end
