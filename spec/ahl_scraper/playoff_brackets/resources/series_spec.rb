# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::Series do
  let(:raw_data) do
    {
      "series_letter": "I",
      "series_name": "Atlantic Division Finals",
      "series_logo": "",
      "round": "2",
      "active": "1",
      "feeder_series1": "A",
      "feeder_series2": "B",
      "team1": "384",
      "team2": "319",
      "content_en": "",
      "content_fr": "",
      "winner": "",
      "games": [
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
        },
      ],
      "team1_wins": 4,
      "team2_wins": 0,
      "ties": 0,
    }
  end

  it "converts raw data into Series record" do
    series = described_class.new(raw_data)

    expect(series.id).to eq("I")
    expect(series.name).to eq("Atlantic Division Finals")
    expect(series.feeder_series1).to eq("A")
    expect(series.feeder_series2).to eq("B")
    expect(series.active?).to eq(true)
    expect(series.logo_url).to eq("")
    expect(series.team1).to eq(384)
    expect(series.team2).to eq(319)
    expect(series.winning_team).to be_nil
    expect(series.team1_wins).to eq(4)
    expect(series.team2_wins).to eq(0)
    expect(series.round).to eq(2)
    expect(series.ties).to eq(0)
    expect(series.home_team_id).to eq(384)
    expect(series.games).to all(be_a(AhlScraper::PlayoffBrackets::Game))
  end
end
