# frozen_string_literal: true

RSpec.describe AhlScraper::SkaterGameListItem do
  let(:raw_data) do
    {
      prop: { game: { gameLink: "1001046" } },
      row: {
        date_played: "2005-10-08",
        shots: "2",
        goals: 0,
        pp: 0,
        sh: 0,
        gw: 0,
        plusminus: "-1",
        assists: "1",
        shootout_goals: "0",
        shootout_attempts: "0",
        penalty_minutes: "0",
        points: 1,
        game: "BNG @ PHI",
      },
    }
  end

  it "converts raw data into SkaterGameListItem record", :vcr do
    skater_game = described_class.new(raw_data)

    expect(skater_game.game_id).to eq(1_001_046)
    expect(skater_game.game_name).to eq("BNG @ PHI")
    expect(skater_game.date).to eq("2005-10-08")
    expect(skater_game.shots).to eq(2)
    expect(skater_game.goals).to eq(0)
    expect(skater_game.goals_pp).to eq(0)
    expect(skater_game.goals_sh).to eq(0)
    expect(skater_game.game_winning_goals).to eq(0)
    expect(skater_game.assists).to eq(1)
    expect(skater_game.points).to eq(1)
    expect(skater_game.plus_minus).to eq(-1)
    expect(skater_game.shootout_goals).to eq(0)
    expect(skater_game.shootout_attempts).to eq(0)
    expect(skater_game.penalty_minutes).to eq(0)
  end
end
