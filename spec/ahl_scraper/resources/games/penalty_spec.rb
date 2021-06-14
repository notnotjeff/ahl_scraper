# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Penalty do
  let(:penalty_data) do
    {
      period: { id: "2", shortName: "", longName: "2nd" },
      time: "05:28",
      againstTeam: { id: 372, name: "Rockford IceHogs", city: "Rockford", nickname: "IceHogs", abbreviation: "RFD", logo: "https://assets.leaguestat.com/ahl/logos/372.jpg" },
      minutes: 5,
      description: "Fighting",
      ruleNumber: "",
      takenBy: { id: 6914, firstName: "Nathan", lastName: "Noel", jerseyNumber: 20, position: "LW", birthDate: "" },
      servedBy: { id: 6914, firstName: "Nathan", lastName: "Noel", jerseyNumber: 20, position: "LW", birthDate: "" },
      isPowerPlay: false,
    }
  end
  let(:opts) { { number: 1 } }

  it "imports penalty data" do
    penalty = described_class.new(penalty_data, opts)

    expect(penalty.number).to eq(opts[:number])
    expect(penalty.period).to eq(penalty_data[:period][:id].to_i)
    expect(penalty.time).to eq(penalty_data[:time])
    expect(penalty.minutes).to eq(penalty_data[:minutes])
    expect(penalty.description).to eq(penalty_data[:description])
    expect(penalty.rule_number).to be_nil
    expect(penalty.power_play?).to eq(penalty_data[:isPowerPlay])

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
    let(:penalty_data) do
      {
        period: { id: "1", shortName: "", longName: "1st" },
        time: "00:52",
        againstTeam: { id: 372, name: "Rockford IceHogs", city: "Rockford", nickname: "IceHogs", abbreviation: "RFD", logo: "https://assets.leaguestat.com/ahl/logos/372.jpg" },
        minutes: 2,
        description: "Bench minor - Too many men",
        ruleNumber: "",
        takenBy: nil,
        servedBy: { id: 7432, firstName: "Dylan", lastName: "Sikura", jerseyNumber: 15, position: "RW", birthDate: "" },
        isPowerPlay: true,
      }
    end

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
    let(:penalty_data) do
      {
        period: { id: "1", shortName: "", longName: "1st" },
        time: "00:52",
        againstTeam: { id: 372, name: "Rockford IceHogs", city: "Rockford", nickname: "IceHogs", abbreviation: "RFD", logo: "https://assets.leaguestat.com/ahl/logos/372.jpg" },
        minutes: 2,
        description: "Bench minor - Too many men",
        ruleNumber: "",
        takenBy: { id: 0, firstName: nil, lastName: nil, jerseyNumber: 0, position: "", birthDate: "" },
        servedBy: { id: 0, firstName: nil, lastName: nil, jerseyNumber: 0, position: "", birthDate: "" },
        isPowerPlay: true,
      }
    end

    it "sets player id as nil" do
      penalty = described_class.new(penalty_data, opts)

      expect(penalty.taken_by[:id]).to eq(nil)
      expect(penalty.served_by[:id]).to eq(nil)
    end
  end
end
