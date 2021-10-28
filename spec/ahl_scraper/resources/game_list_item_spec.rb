# frozen_string_literal: true

RSpec.describe AhlScraper::GameListItem do
  let(:game_data) do
    {
      prop: {
        home_team_city: { teamLink: "323" },
        visiting_team_city: { teamLink: "324" },
        game_report: { link: "https://lscluster.hockeytech.com/game_reports/text-game-report.php?client_code=ahl&game_id=1019623&lang_id=1" },
        game_sheet: { link: "https://lscluster.hockeytech.com/game_reports/official-game-report.php?client_code=ahl&game_id=1019623&lang_id=1" },
        game_summary_long: { link: "/game-summary/?game_id=1019623", gameLink: "1019623" },
        game_center: { link: "/game-center/?game_id=1019623", gameLink: "1019623" },
      },
      row: {
        game_id: "1019623",
        date_with_day: "Fri, Oct 4",
        home_goal_count: "3",
        visiting_goal_count: "2",
        game_status: "Final OT",
        home_team_city: "Rochester",
        visiting_team_city: "Syracuse",
        game_report: "Game Report",
        game_sheet: "Game Sheet",
        game_summary_long: "GAME SUMMARY",
        game_center: "Game Center",
      },
    }
  end

  it "creates valid GameTag object" do
    game_tag = described_class.new(game_data)

    expect(game_tag.id).to eq(1_019_623)
    expect(game_tag.home_team_city).to eq("Rochester")
    expect(game_tag.home_team_id).to eq(323)
    expect(game_tag.home_team_score).to eq(3)
    expect(game_tag.away_team_city).to eq("Syracuse")
    expect(game_tag.away_team_id).to eq(324)
    expect(game_tag.away_team_score).to eq(2)
    expect(game_tag.date).to eq("Fri, Oct 4")
    expect(game_tag.status).to eq("Final OT")
    expect(game_tag.game_report_url).to eq("https://lscluster.hockeytech.com/game_reports/text-game-report.php?client_code=ahl&game_id=1019623&lang_id=1")
    expect(game_tag.game_sheet_url).to eq("https://lscluster.hockeytech.com/game_reports/official-game-report.php?client_code=ahl&game_id=1019623&lang_id=1")
    expect(game_tag.game_center_url).to eq("https://theahl.com/stats/game-center/1019623")
  end

  context "when game has not started" do
    let(:game_data) do
      {
        prop: {
          home_team_city: { teamLink: "307" },
          visiting_team_city: { teamLink: "317" },
          game_center: { link: "/game-center/?game_id=1022628", gameLink: "1022628" },
          mobile_calendar: { link: "https://lscluster.hockeytech.com/components/calendar/ical_add_games.php?client_code=ahl&game_ids=1022628" },
        },
        row: {
          game_id: "1022628",
          date_with_day: "Fri, Oct 15",
          home_goal_count: "-",
          visiting_goal_count: "-",
          game_status: "7:00 pm EDT",
          home_team_city: "Hartford",
          visiting_team_city: "Bridgeport",
          game_center: "Game Center",
          mobile_calendar: "Add to Calendar",
        },
      }
    end

    it "creates valid GameTag object" do
      game_tag = described_class.new(game_data)

      expect(game_tag.id).to eq(1_022_628)
      expect(game_tag.home_team_city).to eq("Hartford")
      expect(game_tag.home_team_id).to eq(307)
      expect(game_tag.home_team_score).to eq(0)
      expect(game_tag.away_team_city).to eq("Bridgeport")
      expect(game_tag.away_team_id).to eq(317)
      expect(game_tag.away_team_score).to eq(0)
      expect(game_tag.date).to eq("Fri, Oct 15")
      expect(game_tag.status).to eq("Not Started")
      expect(game_tag.game_report_url).to be_nil
      expect(game_tag.game_sheet_url).to be_nil
      expect(game_tag.game_center_url).to eq("https://theahl.com/stats/game-center/1022628")
    end
  end
end
