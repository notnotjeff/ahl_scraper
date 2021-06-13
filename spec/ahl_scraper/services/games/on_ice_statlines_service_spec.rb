# frozen_string_literal: true

RSpec.describe AhlScraper::Games::OnIceStatlinesService do
  let(:goal_data) do
    [
      {
        game_goal_id: "93350",
        team: { id: 373, name: "Cleveland Monsters", city: "Cleveland", nickname: "Monsters", abbreviation: "CLE", logo: "https://assets.leaguestat.com/ahl/logos/373_61.jpg", divisionName: "North Division" },
        period: { id: "2", shortName: "", longName: "2nd" }, time: "1:58", scorerGoalNumber: "1", scoredBy: { id: 7442, firstName: "Eric", lastName: "Robinson", jerseyNumber: 19, position: "LW", birthDate: "" },
        assists: [{ id: 3543, firstName: "Zac", lastName: "Dalpe", jerseyNumber: 28, position: "C", birthDate: "" }],
        assistNumbers: %w[1 0],
        properties: { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "0" },
        plus_players: [{ id: 6725, firstName: "Ryan", lastName: "Collins", jerseyNumber: 6, position: "D", birthDate: "" }, { id: 7442, firstName: "Eric", lastName: "Robinson", jerseyNumber: 19, position: "LW", birthDate: "" }, { id: 6636, firstName: "Sam", lastName: "Vigneault", jerseyNumber: 21, position: "C", birthDate: "" }, { id: 6887, firstName: "Doyle", lastName: "Somerby", jerseyNumber: 26, position: "D", birthDate: "" }, { id: 3543, firstName: "Zac", lastName: "Dalpe", jerseyNumber: 28, position: "C", birthDate: "" }],
        minus_players: [{ id: 6632, firstName: "Luc", lastName: "Snuggerud", jerseyNumber: 4, position: "D", birthDate: "" }, { id: 3555, firstName: "Jordan", lastName: "Schroeder", jerseyNumber: 10, position: "RW", birthDate: "" }, { id: 7434, firstName: "Lucas", lastName: "Carlsson", jerseyNumber: 23, position: "D", birthDate: "" }, { id: 7046, firstName: "Victor", lastName: "Ejdsell", jerseyNumber: 39, position: "F", birthDate: "" }, { id: 6629, firstName: "Anthony", lastName: "Louis", jerseyNumber: 45, position: "LW", birthDate: "" }],
      },
    ]
  end
  let(:team_id) { 372 }
  let(:skater_ids) do
    [
      *goal_data[0][:plus_players].map { |pl| pl[:id] },
      *goal_data[0][:minus_players].map { |pl| pl[:id] },
    ]
  end

  it "converts goal data into a team's skater's on ice statlines" do
    on_ice_statlines = described_class.new(goal_data, team_id, skater_ids).call

    expect(on_ice_statlines.keys.length).to eq(skater_ids.length)
  end
end
