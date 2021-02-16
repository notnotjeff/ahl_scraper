# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::Game do
  let(:raw_data) do
    {
      "game_id": "1019576",
      "home_team": "384",
      "home_goal_count": "4",
      "visiting_team": "319",
      "visiting_goal_count": "1",
      "status": "4",
      "game_status": "Final",
      "date_time": "2019-05-03 19:00:00",
      "if_necessary": "0",
      "game_notes": "",
    }
  end

  it "converts raw data into Game record" do
    game = described_class.new(raw_data)

    expect(game.away_team).to eq(319)
    expect(game.notes).to eq("")
    expect(game.status).to eq("Final")
    expect(game.id).to eq(1_019_576)
    expect(game.home_team).to eq(384)
    expect(game.home_score).to eq(4)
    expect(game.date).to eq("2019-05-03 19:00:00")
    expect(game.away_score).to eq(1)
    expect(game.if_necessary?).to eq(false)
  end
end
