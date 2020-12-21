# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Goalie do
  let(:raw_data) do
    {
      info: { id: 3621, firstName: "Jean-Francois", lastName: "Berube", jerseyNumber: 35, position: "G", birthDate: "1991-07-13" },
      stats: { goals: 0, assists: 0, points: 0, penaltyMinutes: 0, plusMinus: 0, faceoffAttempts: 0, faceoffWins: 0, timeOnIce: "60:00", shotsAgainst: 25, goalsAgainst: 1, saves: 24 }, starting: 1, status: "",
    }
  end

  it "converts raw_data into goalie record" do
    goalie = described_class.new(raw_data)

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
