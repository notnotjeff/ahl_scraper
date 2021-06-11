# frozen_string_literal: true

RSpec.describe AhlScraper::Games::CreateSkatersService do
  let(:skater_data) do
    [
      {
        info: { id: 7117, firstName: "Austin", lastName: "Strand", jerseyNumber: 2, position: "D", birthDate: "1997-02-17" },
        stats: { goals: 0, assists: 0, points: 0, penaltyMinutes: 0, plusMinus: 0, faceoffAttempts: 0, faceoffWins: 0, shots: 2, hits: 0 },
        starting: 0,
        status: "",
      },
    ]
  end
  let(:goal_data) do
    [
      {
        scoredBy: { id: 5636 },
        team: { id: 372 },
        assists: [],
        properties: { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "0" },
        plus_players: [7117, 2, 3, 4, 5],
        minus_players: [6, 7, 8, 9, 10],
      },
      {
        scoredBy: { id: 5636 },
        team: { id: 335 },
        assists: [],
        properties: { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "0" },
        plus_players: [6, 7, 8, 9, 10],
        minus_players: [7117, 2, 3, 4, 5],
      },
    ]
  end
  let(:skater_ids) { [7117, 2, 3, 4, 5, 21, 22, 23, 24, 25] }
  let(:team_id) { 372 }
  let(:team_abbreviation) { "RFD" }
  let(:home_team) { true }
  let(:penalty_data) { [] }
  let(:penalty_shot_data) { [] }
  let(:shootout_data) { [] }

  it "converts goal data into a team's skater's on ice statlines", :aggregate_failures do
    expect_next_instance_of(AhlScraper::Games::Format::ScoringStatlines) { |formatter| expect(formatter).to receive(:call).and_return({ "7117": {} }) }
    expect_next_instance_of(AhlScraper::Games::Format::OnIceStatlines) { |formatter| expect(formatter).to receive(:call).and_return({ "7117": {} }) }
    expect_next_instance_of(AhlScraper::Games::Format::PenaltyStatlines) { |formatter| expect(formatter).to receive(:call).and_return({ "7117": {} }) }
    expect_next_instance_of(AhlScraper::Games::Format::PenaltyShotStatlines) { |formatter| expect(formatter).to receive(:call).and_return({ "7117": {} }) }
    expect_next_instance_of(AhlScraper::Games::Format::ShootoutStatlines) { |formatter| expect(formatter).to receive(:call).and_return({ "7117": {} }) }

    skaters = described_class.new(
      skater_data,
      goal_data,
      penalty_data,
      shootout_data,
      penalty_shot_data,
      { home_team: home_team, team_id: team_id, team_abbreviation: team_abbreviation }
    ).call

    expect(skaters.length).to eq(skater_data.length)
  end
end
