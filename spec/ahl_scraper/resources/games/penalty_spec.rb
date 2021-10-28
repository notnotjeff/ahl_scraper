# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Penalty do
  let(:penalty_id) { 249_878 }
  let(:taken_by) { { id: 6914, firstName: "Nathan", lastName: "Noel", jerseyNumber: 20, position: "LW", birthDate: "" } }
  let(:served_by) { taken_by }
  let(:period) { { id: "2", shortName: "", longName: "2nd" } }
  let(:against_team) { { id: 372, name: "Rockford IceHogs", city: "Rockford", nickname: "IceHogs", abbreviation: "RFD", logo: "https://assets.leaguestat.com/ahl/logos/372.jpg" } }
  let(:description) { "Fighting" }
  let(:time) { "05:28" }
  let(:minutes) { 5 }
  let(:rule_number) { "" }
  let(:is_powerplay) { false }
  let(:is_bench) { false }
  let(:penalty_data) do
    {
      game_penalty_id: penalty_id,
      period: period,
      time: time,
      againstTeam: against_team,
      minutes: minutes,
      description: description,
      ruleNumber: rule_number,
      takenBy: taken_by,
      servedBy: served_by,
      isPowerPlay: is_powerplay,
      isBench: is_bench,
    }
  end
  let(:opts) { { number: 1 } }

  it "imports penalty data" do
    penalty = described_class.new(penalty_data, opts)

    expect(penalty.id).to eq(penalty_data[:game_penalty_id])
    expect(penalty.number).to eq(opts[:number])
    expect(penalty.period).to eq(penalty_data[:period][:id].to_i)
    expect(penalty.time).to eq(penalty_data[:time])
    expect(penalty.minutes).to eq(penalty_data[:minutes])
    expect(penalty.description).to eq(penalty_data[:description])
    expect(penalty.rule_number).to be_nil
    expect(penalty.power_play?).to eq(penalty_data[:isPowerPlay])
    expect(penalty.bench?).to eq(penalty_data[:isBench])
    expect(penalty.invalid?).to be_falsey

    expect(penalty.penalized_team[:id]).to eq(penalty_data[:againstTeam][:id])
    expect(penalty.penalized_team[:name]).to eq(penalty_data[:againstTeam][:name])
    expect(penalty.penalized_team[:city]).to eq(penalty_data[:againstTeam][:city])
    expect(penalty.penalized_team[:nickname]).to eq(penalty_data[:againstTeam][:nickname])
    expect(penalty.penalized_team[:abbreviation]).to eq(penalty_data[:againstTeam][:abbreviation])
    expect(penalty.penalized_team[:logo]).to eq(penalty_data[:againstTeam][:logo])

    expect(penalty.served_by[:id]).to eq(penalty_data[:servedBy][:id])
    expect(penalty.served_by[:first_name]).to eq(penalty_data[:servedBy][:firstName])
    expect(penalty.served_by[:last_name]).to eq(penalty_data[:servedBy][:lastName])
    expect(penalty.served_by[:jersey_number]).to eq(penalty_data[:servedBy][:jerseyNumber])
    expect(penalty.served_by[:position]).to eq(penalty_data[:servedBy][:position])
    expect(penalty.served_by[:birthdate]).to eq(penalty_data[:servedBy][:birthdate])

    expect(penalty.taken_by[:id]).to eq(penalty_data[:takenBy][:id])
    expect(penalty.taken_by[:first_name]).to eq(penalty_data[:takenBy][:firstName])
    expect(penalty.taken_by[:last_name]).to eq(penalty_data[:takenBy][:lastName])
    expect(penalty.taken_by[:jersey_number]).to eq(penalty_data[:takenBy][:jerseyNumber])
    expect(penalty.taken_by[:position]).to eq(penalty_data[:takenBy][:position])
    expect(penalty.taken_by[:birthdate]).to eq(penalty_data[:takenBy][:birthdate])
  end

  context "when penalty is served by another player" do
    let(:taken_by) { nil }
    let(:served_by) { { id: 7432, firstName: "Dylan", lastName: "Sikura", jerseyNumber: 15, position: "RW", birthDate: "" } }

    it "imports nil infractor data into object" do
      penalty = described_class.new(penalty_data, opts)

      expect(penalty.taken_by[:id]).to eq(nil)
      expect(penalty.taken_by[:first_name]).to eq(nil)
      expect(penalty.taken_by[:last_name]).to eq(nil)
      expect(penalty.taken_by[:jersey_number]).to eq(nil)
      expect(penalty.taken_by[:position]).to eq(nil)
      expect(penalty.taken_by[:birthdate]).to eq(nil)
    end
  end

  context "when player id is 0" do
    let(:taken_by) { { id: 0, firstName: nil, lastName: nil, jerseyNumber: 0, position: "", birthDate: "" } }

    it "sets player id as nil" do
      penalty = described_class.new(penalty_data, opts)

      expect(penalty.taken_by[:id]).to eq(nil)
      expect(penalty.served_by[:id]).to eq(nil)
    end
  end

  context "when penalty is on invalid list" do
    let(:penalty_id) { 240_773 }

    it "sets invalid? to true" do
      penalty = described_class.new(penalty_data, opts)

      expect(penalty.invalid?).to be_truthy
    end
  end

  context "when penalty shot penalty" do
    let(:description) { "Penalty Shot - Tripping from behind" }

    it "sets type to penalty shot" do
      penalty = described_class.new(penalty_data, opts)

      expect(penalty.penalty_type).to eq(:penalty_shot)
    end
  end
end
