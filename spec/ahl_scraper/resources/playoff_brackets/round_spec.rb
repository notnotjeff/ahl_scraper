# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::Round do
  let(:raw_data) do
    {
      "round": "1",
      "round_name": "Round 1",
      "season_id": "64",
      "round_type_id": "1",
      "round_type_name": "Regular Playoff Series",
      "matchups": [],
    }
  end

  it "converts raw data into Round record" do
    round = described_class.new(raw_data)

    expect(round.id).to eq(1)
    expect(round.name).to eq("Round 1")
    expect(round.season_id).to eq(64)
    expect(round.round_type_id).to eq(1)
    expect(round.round_type_name).to eq("Regular Playoff Series")
    expect(round.series).to all(be_a(AhlScraper::PlayoffBrackets::Series))
  end
end
