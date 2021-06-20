# frozen_string_literal: true

RSpec.describe AhlScraper::GoalieGameListItem do
  let(:raw_data) do
    {
      prop: { game: { gameLink: "1001242" } },
      row: {
        date_played: "2005-11-19",
        goals_against: "2",
        win: "0",
        loss: "0",
        shutout: "0",
        ot_loss: "0",
        saves: "8",
        shots_against: "10",
        gaa: "4.25",
        svpct: "0.800",
        minutes: "28:13",
        game: "BNG @ ALB",
      },
    }
  end

  it "converts raw data into GoalieGameListItem record", :vcr do
    goalie_game = described_class.new(raw_data)

    expect(goalie_game.game_id).to eq(1_001_242)
    expect(goalie_game.game_name).to eq("BNG @ ALB")
    expect(goalie_game.date).to eq("2005-11-19")
    expect(goalie_game.goals_against).to eq(2)
    expect(goalie_game.result).to eq("played_but_no_result")
    expect(goalie_game.shutout?).to eq(false)
    expect(goalie_game.saves).to eq(8)
    expect(goalie_game.shots_against).to eq(10)
    expect(goalie_game.goals_against_average).to eq(4.25)
    expect(goalie_game.save_percent).to eq(0.800)
    expect(goalie_game.minutes).to eq("28:13")
  end
end
