# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Format::MergeGoal do
  let(:blank_statline) do
    {
      goals_as: 0,
      a1_as: 0,
      a2_as: 0,
      points_as: 0,
      goals_es: 0,
      a1_es: 0,
      a2_es: 0,
      points_es: 0,
      goals_5v5: 0,
      a1_5v5: 0,
      a2_5v5: 0,
      points_5v5: 0,
      goals_pp: 0,
      a1_pp: 0,
      a2_pp: 0,
      points_pp: 0,
    }
  end
  let(:statlines) { { 1 => { **blank_statline }, 2 => { **blank_statline }, 3 => { **blank_statline } } }
  let(:plus_players) { [1, 2, 3, 4, 5] }
  let(:minus_players) { [1, 2, 3, 4, 5] }
  let(:properties) { { isPowerPlay: "0", isShortHanded: "0", isEmptyNet: "0", isPenaltyShot: "0", isInsuranceGoal: "0", isGameWinningGoal: "0" } }
  let(:assists) { [{ id: 2 }, { id: 3 }] }
  let(:goal_data) do
    {
      scoredBy: { id: 1 },
      assists: assists,
      properties: properties,
      plus_players: plus_players,
      minus_players: minus_players,
    }
  end

  context "when even strength" do
    it "does not add to non-even strength fields" do
      described_class.new(goal_data, statlines).call

      expect(statlines[1][:goals_pp]).to eq(0)
      expect(statlines[1][:points_pp]).to eq(0)
      expect(statlines[2][:a1_pp]).to eq(0)
      expect(statlines[2][:points_pp]).to eq(0)
      expect(statlines[3][:a2_pp]).to eq(0)
      expect(statlines[3][:points_pp]).to eq(0)
    end

    context "when 5v5" do
      it "adds goals, assists, and points to players" do
        described_class.new(goal_data, statlines).call

        expect(statlines[1][:goals_as]).to eq(1)
        expect(statlines[1][:points_as]).to eq(1)
        expect(statlines[1][:goals_es]).to eq(1)
        expect(statlines[1][:points_es]).to eq(1)
        expect(statlines[1][:goals_5v5]).to eq(1)
        expect(statlines[1][:points_5v5]).to eq(1)
        expect(statlines[2][:a1_as]).to eq(1)
        expect(statlines[2][:points_as]).to eq(1)
        expect(statlines[2][:a1_es]).to eq(1)
        expect(statlines[2][:points_es]).to eq(1)
        expect(statlines[2][:a1_5v5]).to eq(1)
        expect(statlines[2][:points_5v5]).to eq(1)
        expect(statlines[3][:a2_as]).to eq(1)
        expect(statlines[3][:points_as]).to eq(1)
        expect(statlines[3][:a2_es]).to eq(1)
        expect(statlines[3][:points_es]).to eq(1)
        expect(statlines[3][:a2_5v5]).to eq(1)
        expect(statlines[3][:points_5v5]).to eq(1)
      end
    end

    context "when not 5v5" do
      let(:plus_players) { [1, 2, 3, 4] }
      let(:minus_players) { [1, 2, 3, 4] }

      it "adds goals, assists, and points to players" do
        described_class.new(goal_data, statlines).call

        expect(statlines[1][:goals_as]).to eq(1)
        expect(statlines[1][:points_as]).to eq(1)
        expect(statlines[1][:goals_es]).to eq(1)
        expect(statlines[1][:points_es]).to eq(1)
        expect(statlines[1][:goals_5v5]).to eq(0)
        expect(statlines[1][:points_5v5]).to eq(0)
        expect(statlines[2][:a1_as]).to eq(1)
        expect(statlines[2][:points_as]).to eq(1)
        expect(statlines[2][:a1_es]).to eq(1)
        expect(statlines[2][:points_es]).to eq(1)
        expect(statlines[2][:a1_5v5]).to eq(0)
        expect(statlines[2][:points_5v5]).to eq(0)
        expect(statlines[3][:a2_as]).to eq(1)
        expect(statlines[3][:points_as]).to eq(1)
        expect(statlines[3][:a2_es]).to eq(1)
        expect(statlines[3][:points_es]).to eq(1)
        expect(statlines[3][:a2_5v5]).to eq(0)
        expect(statlines[3][:points_5v5]).to eq(0)
      end
    end
  end

  context "when powerplay" do
    let(:plus_players) { [1, 2, 3, 4, 5] }
    let(:minus_players) { [1, 2, 3, 4] }
    let(:properties) { { isPowerPlay: "1" } }

    it "does not add points to non-powerplay keys" do
      described_class.new(goal_data, statlines).call

      expect(statlines[1][:goals_es]).to eq(0)
      expect(statlines[1][:points_es]).to eq(0)
      expect(statlines[1][:goals_5v5]).to eq(0)
      expect(statlines[1][:points_5v5]).to eq(0)
      expect(statlines[2][:a1_es]).to eq(0)
      expect(statlines[2][:points_es]).to eq(0)
      expect(statlines[2][:a1_5v5]).to eq(0)
      expect(statlines[2][:points_5v5]).to eq(0)
      expect(statlines[3][:a2_es]).to eq(0)
      expect(statlines[3][:points_es]).to eq(0)
      expect(statlines[3][:a2_5v5]).to eq(0)
      expect(statlines[3][:points_5v5]).to eq(0)
    end

    it "adds goals, assists, and points to players" do
      described_class.new(goal_data, statlines).call

      expect(statlines[1][:goals_as]).to eq(1)
      expect(statlines[1][:points_as]).to eq(1)
      expect(statlines[1][:goals_pp]).to eq(1)
      expect(statlines[1][:points_pp]).to eq(1)
      expect(statlines[2][:a1_as]).to eq(1)
      expect(statlines[2][:points_as]).to eq(1)
      expect(statlines[2][:a1_pp]).to eq(1)
      expect(statlines[2][:points_pp]).to eq(1)
      expect(statlines[3][:a2_as]).to eq(1)
      expect(statlines[3][:points_as]).to eq(1)
      expect(statlines[3][:a2_pp]).to eq(1)
      expect(statlines[3][:points_pp]).to eq(1)
    end
  end

  context "when a2 does not exist" do
    let(:assists) { [{ id: 2 }] }

    it "does not add points for a2" do
      described_class.new(goal_data, statlines).call

      expect(statlines[1][:a2_as]).to eq(0)
      expect(statlines[2][:a2_as]).to eq(0)
      expect(statlines[3][:a2_as]).to eq(0)
    end
  end

  context "when a1 and a2 do not exist" do
    let(:assists) { [] }

    it "does not add points for a2" do
      described_class.new(goal_data, statlines).call

      expect(statlines[1][:a1_as]).to eq(0)
      expect(statlines[2][:a1_as]).to eq(0)
      expect(statlines[3][:a1_as]).to eq(0)
      expect(statlines[1][:a2_as]).to eq(0)
      expect(statlines[2][:a2_as]).to eq(0)
      expect(statlines[3][:a2_as]).to eq(0)
    end
  end
end
