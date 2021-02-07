# frozen_string_literal: true

RSpec.describe AhlScraper::Teams::TeamObject do
  let(:season_id) { 65 }
  let(:raw_data) do
    {
      prop: {
        team_code: { teamLink: "309" },
        name: { teamLink: "309" },
      },
      row: {
        team_code: "PRO",
        wins: "38",
        losses: "18",
        ot_losses: "3",
        shootout_losses: "3",
        regulation_wins: "30",
        row: "33",
        points: "82",
        penalty_minutes: "854",
        streak: "12-0-1-0",
        goals_for: "197",
        goals_against: "154",
        percentage: "0.661",
        overall_rank: "2",
        games_played: "62",
        rank: 1,
        past_10: "10-0-0-0",
        name: "Providence Bruins",
      },
    }
  end

  it "converts raw data into TeamObject record", :vcr do
    team = described_class.new(raw_data, season_id)

    expect(team.id).to eq(raw_data[:prop][:team_code][:teamLink].to_i)
    expect(team.name).to eq(raw_data[:row][:name])
    expect(team.season_id).to eq(season_id)
  end
end
