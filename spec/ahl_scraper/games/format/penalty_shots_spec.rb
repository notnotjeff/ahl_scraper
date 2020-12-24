# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Format::PenaltyShots do
  let(:penalty_shot_data) do
    [
      {
        shooter: { id: 6814, firstName: "Spencer", lastName: "Foo", jerseyNumber: 15, position: "RW", birthDate: "1994-05-19" },
        goalie: { id: 5021, firstName: "Jared", lastName: "Coreau", jerseyNumber: 31, position: "G", birthDate: "1991-11-05" },
        shooter_team: { id: 406, name: "Stockton Heat", city: "Stockton", nickname: "Heat", abbreviation: "STK", logo: "https://assets.leaguestat.com/ahl/logos/406_61.jpg" },
        period: { id: "3", shortName: "3", longName: "3rd" }, time: "4:11", isGoal: false,
      },
      {
        shooter: { id: 6814, firstName: "Spencer", lastName: "Foo", jerseyNumber: 15, position: "RW", birthDate: "1994-05-19" },
        goalie: { id: 5021, firstName: "Jared", lastName: "Coreau", jerseyNumber: 31, position: "G", birthDate: "1991-11-05" },
        shooter_team: { id: 406, name: "Stockton Heat", city: "Stockton", nickname: "Heat", abbreviation: "STK", logo: "https://assets.leaguestat.com/ahl/logos/406_61.jpg" },
        period: { id: "2", shortName: "2", longName: "2nd" }, time: "4:47", isGoal: false,
      },
    ]
  end

  it "sorts penalty shot data and converts it into PenaltyShot records" do
    penalty_shots = described_class.new(penalty_shot_data).call

    expect(penalty_shots.map(&:period)).to eq(penalty_shot_data.map { |ps| ps[:period][:id].to_i }.sort)
    expect(penalty_shots.length).to eq(penalty_shot_data.length)
  end

  context "when in the same period" do
    let(:penalty_shot_data) do
      [
        {
          shooter: { id: 2, firstName: "Spencer", lastName: "Foo", jerseyNumber: 15, position: "RW", birthDate: "1994-05-19" },
          goalie: { id: 5021, firstName: "Jared", lastName: "Coreau", jerseyNumber: 31, position: "G", birthDate: "1991-11-05" },
          shooter_team: { id: 406, name: "Stockton Heat", city: "Stockton", nickname: "Heat", abbreviation: "STK", logo: "https://assets.leaguestat.com/ahl/logos/406_61.jpg" },
          period: { id: "2", shortName: "2", longName: "2nd" }, time: "5:11", isGoal: false,
        },
        {
          shooter: { id: 1, firstName: "Spencer", lastName: "Foo", jerseyNumber: 15, position: "RW", birthDate: "1994-05-19" },
          goalie: { id: 5021, firstName: "Jared", lastName: "Coreau", jerseyNumber: 31, position: "G", birthDate: "1991-11-05" },
          shooter_team: { id: 406, name: "Stockton Heat", city: "Stockton", nickname: "Heat", abbreviation: "STK", logo: "https://assets.leaguestat.com/ahl/logos/406_61.jpg" },
          period: { id: "2", shortName: "2", longName: "2nd" }, time: "4:47", isGoal: false,
        },
      ]
    end

    it "uses period time to order" do
      penalty_shots = described_class.new(penalty_shot_data).call

      expect(penalty_shots.map { |ps| ps.shooter[:id] }).to eq([1, 2])
    end
  end
end
