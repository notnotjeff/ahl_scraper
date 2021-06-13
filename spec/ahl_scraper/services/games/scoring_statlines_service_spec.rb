# frozen_string_literal: true

RSpec.describe AhlScraper::Games::ScoringStatlinesService do
  let(:skater_id) { 5636 }
  let(:skater_ids) { [skater_id] }
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

  it "creates statlines hash with every skater id" do
    statlines = described_class.new(goal_data, skater_ids, { home_team: true }).call

    expect(statlines[skater_id.to_s][:goals_as]).to eq(2)
    expect(statlines[skater_id.to_s][:points_as]).to eq(2)
    expect(statlines[skater_id.to_s][:goals_5v5]).to eq(2)
    expect(statlines[skater_id.to_s][:points_5v5]).to eq(2)
    expect(statlines[skater_id.to_s][:goals_ev]).to eq(2)
    expect(statlines[skater_id.to_s][:points_ev]).to eq(2)
  end

  # TODO: Add penalty shot test, game_id: 1022469
end
