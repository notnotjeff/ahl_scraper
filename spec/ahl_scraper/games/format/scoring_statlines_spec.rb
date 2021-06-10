# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Format::ScoringStatlines do
  let(:skater_data) do
    [
      {
        info: { id: 5636, firstName: "Jake", lastName: "Dotchin", jerseyNumber: 2, position: "D", birthDate: "1994-03-24" },
        stats: { goals: 0, assists: 0, points: 0, penaltyMinutes: 2, plusMinus: -1, faceoffAttempts: 0, faceoffWins: 0, shots: 1, hits: 0 },
        starting: 0,
        status: "",
      },

    ]
  end
  let(:goal_data) do
    [
      {
        scoredBy: { id: 5636 },
        assists: [],
        properties: { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "0" },
        plus_players: [1, 2, 3, 4, 5],
        minus_players: [1, 2, 3, 4, 5],
      },
      {
        scoredBy: { id: 5636 },
        assists: [],
        properties: { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "0" },
        plus_players: [1, 2, 3, 4, 5],
        minus_players: [1, 2, 3, 4, 5],
      },

    ]
  end

  it "converts skater and goal data into Skater records" do
    expect(AhlScraper::Games::Format::MergeGoal).to receive(:new).exactly(2).times.and_return(instance_double("AhlScraper::Games::Format::MergeGoal", call: true))

    skaters = described_class.new(skater_data, goal_data, { home_team: true }).call

    expect(skaters.length).to eq(skater_data.length)
    expect(skaters.map(&:id)).to eq(skater_data.map { |s| s[:info][:id] })
  end

  # TODO: Add penalty shot test, game_id: 1022469
end
