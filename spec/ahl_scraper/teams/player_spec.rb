# frozen_string_literal: true

RSpec.describe AhlScraper::Teams::Player do
  let(:is_rookie) { "0" }
  let(:team_id) { 335 }
  let(:season_id) { 61 }
  let(:raw_data) do
    {
      bio: {
        prop: {
          name: { playerLink: "7363", seoName: "Aaron Luchuk" },
        },
        row: { shoots: "L", birthplace: "Kingston, ON", height_hyphenated: "5-10", player_id: "7363", birthdate: "1997-04-04", tp_jersey_number: "9", position: "C", w: "186", name: "Aaron Luchuk" },
      },
      stats: {
        prop: {
          name: { playerLink: "7363", seoName: "Aaron Luchuk" },
          rookie: { rookie: is_rookie }, team_code: { teamLink: "335" },
        },
        row: {
          player_id: "7363",
          name: "Aaron Luchuk",
          position: "C",
          rookie: "0",
          team_code: "TOR",
          games_played: "3",
          goals: "0",
          shots: "0",
          assists: "0",
          points: "0",
          points_per_game: "0.00",
          plus_minus: "-1",
          penalty_minutes: "0",
          penalty_minutes_per_game: "0.00",
          power_play_goals: "0",
          short_handed_goals: "0",
          shootout_goals: "0",
          shootout_attempts: "0",
          shootout_winning_goals: "0",
          shootout_percentage: "0.0",
          rank: 50,
        },
      },
    }
  end

  it "converts raw data into PlayerObject record" do
    player = described_class.new(raw_data, team_id, season_id)

    expect(player.id).to eq(raw_data[:bio][:row][:player_id].to_i)
    expect(player.name).to eq(raw_data[:bio][:row][:name])
    expect(player.shoots).to eq(raw_data[:bio][:row][:shoots])
    expect(player.birthplace).to eq(raw_data[:bio][:row][:birthplace])
    expect(player.height).to eq(raw_data[:bio][:row][:height_hyphenated])
    expect(player.birthdate).to eq(raw_data[:bio][:row][:birthdate])
    expect(player.number).to eq(raw_data[:bio][:row][:tp_jersey_number].to_i)
    expect(player.position).to eq(raw_data[:bio][:row][:position])
    expect(player.weight).to eq(raw_data[:bio][:row][:w].to_i)
    expect(player.rookie?).to eq(false)
  end

  context "when player is a rookie" do
    let(:is_rookie) { "1" }

    it "sets rookie? to true" do
      player = described_class.new(raw_data, team_id, season_id)

      expect(player.rookie?).to eq(true)
    end
  end
end
