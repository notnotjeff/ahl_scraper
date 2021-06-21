# frozen_string_literal: true

RSpec.describe AhlScraper::TeamGameListItem do
  let(:team_id) { 313 }
  let(:raw_data) do
    {
      prop: {
        home_team_city: { teamLink: "319" },
        visiting_team_city: { teamLink: "313" },
        game_report: { link: "https://lscluster.hockeytech.com/game_reports/text-game-report.php?client_code=ahl&game_id=1022057&lang_id=1" },
        game_sheet: { link: "https://lscluster.hockeytech.com/game_reports/official-game-report.php?client_code=ahl&game_id=1022057&lang_id=1" },
        game_summary_long: { link: "/game-summary/?game_id=1022057", gameLink: "1022057" },
        game_center: { link: "/game-center/?game_id=1022057", gameLink: "1022057" },
      },
      row: {
        game_id: "1022057",
        date_with_day: "Sat, Feb 6",
        home_goal_count: "1",
        visiting_goal_count: "2",
        game_status: "Final OT",
        home_team_city: "Hershey",
        visiting_team_city: "Lehigh Valley",
        game_report: "Game Report",
        game_sheet: "Game Sheet",
        game_summary_long: "GAME SUMMARY",
        game_center: "Game Center",
      },
    }
  end

  it "converts raw data into TeamGameListItem record" do
    team_game = described_class.new(raw_data, { team_id: team_id })

    expect(team_game.game_id).to eq(1_022_057)
    expect(team_game.game_name).to eq("Lehigh Valley @ Hershey")
    expect(team_game.date).to eq("Sat, Feb 6")
    expect(team_game.status).to eq("Final OT")
    expect(team_game.game_report_url).to eq("https://lscluster.hockeytech.com/game_reports/text-game-report.php?client_code=ahl&game_id=1022057&lang_id=1")
    expect(team_game.game_sheet_url).to eq("https://lscluster.hockeytech.com/game_reports/official-game-report.php?client_code=ahl&game_id=1022057&lang_id=1")
    expect(team_game.game_center_url).to eq("https://theahl.com/stats/game-center/1022057")
    expect(team_game.home_score).to eq(1)
    expect(team_game.away_score).to eq(2)
    expect(team_game.home_team[:id]).to eq(319)
    expect(team_game.home_team[:city]).to eq("Hershey")
    expect(team_game.away_team[:id]).to eq(313)
    expect(team_game.away_team[:city]).to eq("Lehigh Valley")
    expect(team_game.at_home?).to eq(false)
  end
end
