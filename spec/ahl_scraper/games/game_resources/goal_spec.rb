# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Goal do
  let(:raw_data) do
    {
      team: { id: 372, name: "Rockford IceHogs", city: "Rockford", nickname: "IceHogs", abbreviation: "RFD", logo: "https://assets.leaguestat.com/ahl/logos/372.jpg" },
      period: { id: "1", shortName: "", longName: "1st" },
      time: "17:11",
      scorerGoalNumber: "1",
      scoredBy: { id: 6861, firstName: "Matthew", lastName: "Highmore", jerseyNumber: 9, position: "LW", birthDate: "" },
      assists: [{ id: 7046, firstName: "Victor", lastName: "Ejdsell", jerseyNumber: 39, position: "F", birthDate: "" }, { id: 6632, firstName: "Luc", lastName: "Snuggerud", jerseyNumber: 4, position: "D", birthDate: "" }],
      assistNumbers: %w[1 1],
      properties: { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "0" },
      plus_players: [{ id: 6632, firstName: "Luc", lastName: "Snuggerud", jerseyNumber: 4, position: "D", birthDate: "" }],
      minus_players: [{ id: 6725, firstName: "Ryan", lastName: "Collins", jerseyNumber: 6, position: "D", birthDate: "" }],
    }
  end

  it "converts raw data into goal" do
    number = 1
    goal = described_class.new(raw_data, { number: number })

    expect(goal.number).to equal(number)
    expect(goal.period).to equal(raw_data[:period][:id].to_i)
    expect(goal.time).to equal(raw_data[:time])
    expect(goal.time_in_seconds).to equal(raw_data[:time])
    expect(goal.scorer_goal_number).to equal(raw_data[:scorerGoalNumber])
    expect(goal.scored_by).to eq(raw_data[:scoredBy])
    expect(goal.assists).to match_array(raw_data[:assists])
    expect(goal.assist_numbers).to match_array(raw_data[:assistNumbers])
    expect(goal.power_play?).to eq(raw_data[:properties][:isPowerPlay] == "1")
    expect(goal.short_handed?).to eq(raw_data[:properties][:isShortHanded] == "1")
    expect(goal.empty_net?).to eq(raw_data[:properties][:isEmptyNet] == "1")
    expect(goal.penalty_shot?).to eq(raw_data[:properties][:isInsuranceGoal] == "1")
    expect(goal.game_winner?).to eq(raw_data[:properties][:isGameWinningGoal] == "1")
  end

  # it "converts plus players into on ice skaters" do
  #   goal = described_class.new(raw_data, { number: 1 })

  #   expect(goal.plus_players.pluck(:id)).to include(raw_data.plus_players.pluck("id"))
  # end

  # it "converts minus players into on ice skaters" do
  #   goal = described_class.new(raw_data, { number: 1 })
  # end
end
