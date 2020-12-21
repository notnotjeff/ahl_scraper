# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Overtime do
  let(:raw_data) do
    {
      info: { id: "4", shortName: "OT", longName: "OT" }, stats: { homeGoals: "1", homeShots: "2", visitingGoals: "0", visitingShots: "5" },
      goals: [
        {
          game_goal_id: "103029",
          team: { id: 335, name: "Toronto Marlies", city: "Toronto", nickname: "Marlies", abbreviation: "TOR", logo: "https://assets.leaguestat.com/ahl/logos/335_65.jpg" },
          period: { id: "4", shortName: "", longName: "OT" },
          time: "4:35",
          scorerGoalNumber: "9",
          scoredBy: { id: 5660, firstName: "Kenny", lastName: "Agostino", jerseyNumber: 18, position: "LW", birthDate: "" },
          assists: [{ id: 6893, firstName: "Timothy", lastName: "Liljegren", jerseyNumber: 7, position: "D", birthDate: "" }, { id: 6891, firstName: "Jeremy", lastName: "Bracco", jerseyNumber: 27, position: "RW", birthDate: "" }],
          assistNumbers: %w[8 12],
          properties: { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "1" },
          plus_players: [{ id: 6893, firstName: "Timothy", lastName: "Liljegren", jerseyNumber: 7, position: "D", birthDate: "" }],
          minus_players: [{ id: 7381, firstName: "Jake", lastName: "Evans", jerseyNumber: 10, position: "C", birthDate: "" }],
        },
      ],
      penalties: [],
    }
  end

  it "converts raw data to Overtime record" do
    overtime = described_class.new(raw_data, { regular_season: true })

    expect(overtime.number).to eq(raw_data[:info][:id].to_i - 3)
    expect(overtime.name).to eq(raw_data[:info][:longName] + raw_data[:info][:id])
    expect(overtime.length).to eq("4:35")
    expect(overtime.length_in_seconds).to eq(275)
    expect(overtime.scoring?).to eq(true)
    expect(overtime.home_goals).to eq(raw_data[:stats][:homeGoals])
    expect(overtime.home_shots).to eq(raw_data[:stats][:homeShots])
    expect(overtime.away_goals).to eq(raw_data[:stats][:visitingGoals])
    expect(overtime.away_shots).to eq(raw_data[:stats][:visitingShots])
  end

  context "when overtime has no goals" do
    let(:raw_data) do
      {
        info: { id: "4", shortName: "OT", longName: "OT" }, stats: { homeGoals: "0", homeShots: "3", visitingGoals: "0", visitingShots: "1" },
        goals: [],
      }
    end

    it "sets appropriate variables" do
      overtime = described_class.new(raw_data, { regular_season: true })

      expect(overtime.length).to eq("5:00")
      expect(overtime.length_in_seconds).to eq(300)
      expect(overtime.scoring?).to eq(raw_data[:goals].any?)
    end
  end

  context "when playoff overtime" do
    let(:raw_data) do
      {
        info: { id: "4", shortName: "OT", longName: "OT" }, stats: { homeGoals: "0", homeShots: "3", visitingGoals: "0", visitingShots: "1" },
        goals: [],
      }
    end

    it "changes the length to 20 minutes" do
      overtime = described_class.new(raw_data, { regular_season: false })

      expect(overtime.length).to eq("20:00")
      expect(overtime.length_in_seconds).to eq(1200)
    end
  end
end
