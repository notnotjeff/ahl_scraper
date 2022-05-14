# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::Round do
  let(:raw_data) do
    {
      "round": round,
      "round_name": "Round 1",
      "season_id": "64",
      "round_type_id": "1",
      "round_type_name": "Regular Playoff Series",
      "matchups": [matchup],
    }
  end
  let(:round) { "1" }
  let(:team1_id) { "318" }
  let(:team2_id) { "319" }
  let(:active_series) { "1" }
  let(:matchup) do
    {
      series_letter: "I",
      series_name: "Atlantic Division Finals",
      series_logo: "",
      round: round,
      active: active_series,
      feeder_series1: "A",
      feeder_series2: "B",
      team1: team1_id,
      team2: team2_id,
      content_en: "",
      content_fr: "",
      winner: team1_id,
      games: [],
      team1_wins: "0",
      team2_wins: "0",
      ties: 0,
    }
  end

  it "converts raw data into Round record" do
    round = described_class.new(raw_data)

    expect(round.id).to eq(1)
    expect(round.name).to eq("Round 1")
    expect(round.season_id).to eq(64)
    expect(round.round_type_id).to eq(1)
    expect(round.round_type_name).to eq("Regular Playoff Series")
    expect(round.started?).to be_truthy
    expect(round.series).to all(be_a(AhlScraper::PlayoffBrackets::Series))
  end

  context "when no series has started" do
    let(:team1_id) { "0" }
    let(:team2_id) { "0" }

    it "returns started? as false" do
      round = described_class.new(raw_data)

      expect(round.started?).to be_falsey
    end
  end
end
