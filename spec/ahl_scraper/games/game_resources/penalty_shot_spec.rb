# frozen_string_literal: true

RSpec.describe AhlScraper::Games::PenaltyShot do
  let(:raw_data) do
    {
      shooter: { id: 6814, firstName: "Spencer", lastName: "Foo", jerseyNumber: 15, position: "RW", birthDate: "1994-05-19" },
      goalie: { id: 5021, firstName: "Jared", lastName: "Coreau", jerseyNumber: 31, position: "G", birthDate: "1991-11-05" },
      shooter_team: { id: 406, name: "Stockton Heat", city: "Stockton", nickname: "Heat", abbreviation: "STK", logo: "https://assets.leaguestat.com/ahl/logos/406_61.jpg" },
      period: { id: "2", shortName: "2", longName: "2nd" },
      time: "4:47",
      isGoal: false,
    }
  end

  it "converts raw data into PenaltyShot" do
    number = 1
    penalty_shot = described_class.new(raw_data, { number: number })

    expect(penalty_shot.number).to eq(number)
    expect(penalty_shot.shooter[:id]).to eq(raw_data[:shooter][:id])
    expect(penalty_shot.shooter[:first_name]).to eq(raw_data[:shooter][:firstName])
    expect(penalty_shot.shooter[:last_name]).to eq(raw_data[:shooter][:lastName])
    expect(penalty_shot.shooter[:jersey_number]).to eq(raw_data[:shooter][:jerseyNumber])
    expect(penalty_shot.shooter[:position]).to eq(raw_data[:shooter][:position])
    expect(penalty_shot.goalie[:id]).to eq(raw_data[:goalie][:id])
    expect(penalty_shot.goalie[:first_name]).to eq(raw_data[:goalie][:firstName])
    expect(penalty_shot.goalie[:last_name]).to eq(raw_data[:goalie][:lastName])
    expect(penalty_shot.goalie[:jersey_number]).to eq(raw_data[:goalie][:jerseyNumber])
    expect(penalty_shot.goalie[:position]).to eq(raw_data[:goalie][:position])
    expect(penalty_shot.shooting_team[:id]).to eq(raw_data[:shooter_team][:id])
    expect(penalty_shot.shooting_team[:full_name]).to eq(raw_data[:shooter_team][:name])
    expect(penalty_shot.shooting_team[:city]).to eq(raw_data[:shooter_team][:city])
    expect(penalty_shot.shooting_team[:name]).to eq(raw_data[:shooter_team][:nickname])
    expect(penalty_shot.shooting_team[:abbreviation]).to eq(raw_data[:shooter_team][:abbreviation])
    expect(penalty_shot.shooting_team[:logo_url]).to eq(raw_data[:shooter_team][:logo])
    expect(penalty_shot.period).to eq(raw_data[:period][:id].to_i)
    expect(penalty_shot.time).to eq(raw_data[:time])
    expect(penalty_shot.time_in_seconds).to eq(287)
    expect(penalty_shot.scored?).to eq(raw_data[:isGoal] == true)
  end
end
