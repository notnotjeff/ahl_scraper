# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::PlayoffBracketObject do
  let(:raw_data) do
    {
      "teams": {
        "323": {
          "id": "323",
          "city": "Rochester",
          "team_code": "ROC",
          "name": "Rochester Americans",
          "division_long_name": "North Division",
          "division_short_name": "North",
          "conf_id": "1",
          "logo": "https://assets.leaguestat.com/ahl/logos/323.jpg",
        },
      },
      "rounds": [
        {
          "round": "1",
          "round_name": "Round 1",
          "season_id": "64",
          "round_type_id": "1",
          "round_type_name": "Regular Playoff Series",
          "matchups": [
            {
              "series_letter": "A",
              "series_name": "Atlantic Division Semifinals",
              "series_logo": "",
              "round": "1",
              "active": "1",
              "feeder_series1": "N/A",
              "feeder_series2": "N/A",
              "team1": "384",
              "team2": "309",
              "content_en": "",
              "content_fr": "",
              "winner": "",
              "games": [
                {
                  "game_id": "1019529",
                  "home_team": "309",
                  "home_goal_count": "4",
                  "visiting_team": "384",
                  "visiting_goal_count": "5",
                  "status": "4",
                  "game_status": "Final",
                  "date_time": "2019-04-20 19:05:00",
                  "if_necessary": "0",
                  "game_notes": "",
                },
              ],
              "team1_wins": 3,
              "team2_wins": 1,
              "ties": 0,
            },
          ],
        },
      ],
      "logo": "https://lscluster.hockeytech.com/download.php?file_path=img/playoffs_64.jpg&client_code=ahl",
    }
  end

  it "converts raw data into PlayoffBracketObject record" do
    bracket = described_class.new(raw_data)

    expect(bracket.teams).to all(be_a(AhlScraper::PlayoffBrackets::Team))
    expect(bracket.rounds).to all(be_a(AhlScraper::PlayoffBrackets::Round))
    expect(bracket.logo_url).to eq("https://lscluster.hockeytech.com/download.php?file_path=img/playoffs_64.jpg&client_code=ahl")
  end
end
