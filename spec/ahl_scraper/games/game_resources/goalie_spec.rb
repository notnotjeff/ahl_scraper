# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Goalie do
  let(:raw_data) do
    {
      info: { id: 3621, firstName: "Jean-Francois", lastName: "Berube", jerseyNumber: 35, position: "G", birthDate: "1991-07-13" },
      stats: { goals: 0, assists: 0, points: 0, penaltyMinutes: 0, plusMinus: 0, faceoffAttempts: 0, faceoffWins: 0, timeOnIce: "60:00", shotsAgainst: 25, goalsAgainst: 1, saves: 24 }, starting: 1, status: "",
    }
  end
  let(:shootout_data) do
    [
      {
        shooter: { id: 7381, firstName: "Jake", lastName: "Evans", jerseyNumber: 10, position: "C", birthDate: "1996-06-02" },
        goalie: { id: 3621, firstName: "Jean-Francois", lastName: "Berube", jerseyNumber: 35, position: "G", birthDate: "1991-07-13" },
        isGoal: false,
        isGameWinningGoal: false,
        shooterTeam: { id: 415, name: "Laval Rocket", city: "Laval", nickname: "Rocket", abbreviation: "LAV", logo: "https://assets.leaguestat.com/ahl/logos/415.jpg" },
      },
      {
        shooter: { id: 7311, firstName: "John", lastName: "Doe", jerseyNumber: 10, position: "C", birthDate: "1996-06-02" },
        goalie: { id: 3621, firstName: "Jean-Francois", lastName: "Berube", jerseyNumber: 35, position: "G", birthDate: "1991-07-13" },
        isGoal: true,
        isGameWinningGoal: false,
        shooterTeam: { id: 415, name: "Laval Rocket", city: "Laval", nickname: "Rocket", abbreviation: "LAV", logo: "https://assets.leaguestat.com/ahl/logos/415.jpg" },
      },
    ]
  end
  let(:penalty_shot_data) do
    [
      {
        shooter: { id: 6814, firstName: "Spencer", lastName: "Foo", jerseyNumber: 15, position: "RW", birthDate: "1994-05-19" },
        goalie: { id: 3621, firstName: "Jean-Francois", lastName: "Berube", jerseyNumber: 35, position: "G", birthDate: "1991-07-13" },
        shooter_team: { id: 406, name: "Stockton Heat", city: "Stockton", nickname: "Heat", abbreviation: "STK", logo: "https://assets.leaguestat.com/ahl/logos/406_61.jpg" },
        period: { id: "2", shortName: "2", longName: "2nd" },
        time: "4:47",
        isGoal: true,
      },
    ]
  end

  it "converts raw_data into goalie record" do
    goalie = described_class.new(raw_data, { team_id: 335, home_team: true, shootout_data: shootout_data, penalty_shot_data: penalty_shot_data })

    expect(goalie.id).to eq(raw_data[:info][:id])
    expect(goalie.first_name).to eq(raw_data[:info][:firstName])
    expect(goalie.last_name).to eq(raw_data[:info][:lastName])
    expect(goalie.jersey_number).to eq(raw_data[:info][:jerseyNumber])
    expect(goalie.position).to eq(raw_data[:info][:position])
    expect(goalie.birthdate).to eq(raw_data[:info][:birthDate])
    expect(goalie.stats[:goals]).to eq(raw_data[:stats][:goals])
    expect(goalie.stats[:assists]).to eq(raw_data[:stats][:assists])
    expect(goalie.stats[:points]).to eq(raw_data[:stats][:points])
    expect(goalie.stats[:penalty_minutes]).to eq(raw_data[:stats][:penaltyMinute])
    expect(goalie.stats[:plus_minus]).to eq(raw_data[:stats][:plusMinus])
    expect(goalie.stats[:faceoff_attempts]).to eq(raw_data[:stats][:faceoffAttempts])
    expect(goalie.stats[:faceoff_wins]).to eq(raw_data[:stats][:faceoffwins])
    expect(goalie.stats[:toi]).to eq(raw_data[:stats][:timeOnIce])
    expect(goalie.stats[:shots_against]).to eq(raw_data[:stats][:shotsAgainst])
    expect(goalie.stats[:goals_against]).to eq(raw_data[:stats][:goalsAgainst])
    expect(goalie.stats[:saves]).to eq(raw_data[:stats][:saves])
    expect(goalie.starting).to eq(raw_data[:starting])
    expect(goalie.status).to eq(raw_data[:status])
  end
end
