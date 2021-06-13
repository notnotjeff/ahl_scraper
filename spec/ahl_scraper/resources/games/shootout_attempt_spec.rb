# frozen_string_literal: true

RSpec.describe AhlScraper::Games::ShootoutAttempt do
  let(:raw_data) do
    {
      shooter: { id: 7381, firstName: "Jake", lastName: "Evans", jerseyNumber: 10, position: "C", birthDate: "1996-06-02" },
      goalie: { id: 8003, firstName: "Joseph", lastName: "Woll", jerseyNumber: 35, position: "G", birthDate: "1998-07-12" },
      isGoal: false,
      isGameWinningGoal: false,
      shooterTeam: { id: 415, name: "Laval Rocket", city: "Laval", nickname: "Rocket", abbreviation: "LAV", logo: "https://assets.leaguestat.com/ahl/logos/415.jpg" },
    }
  end

  it "converts raw data into ShootoutAttempt" do
    number = 1
    attempt = described_class.new(raw_data, { number: number })

    expect(attempt.number).to eq(number)
    expect(attempt.shooter[:id]).to eq(raw_data[:shooter][:id])
    expect(attempt.shooter[:first_name]).to eq(raw_data[:shooter][:firstName])
    expect(attempt.shooter[:last_name]).to eq(raw_data[:shooter][:lastName])
    expect(attempt.shooter[:jersey_number]).to eq(raw_data[:shooter][:jerseyNumber])
    expect(attempt.shooter[:position]).to eq(raw_data[:shooter][:position])
    expect(attempt.goalie[:id]).to eq(raw_data[:goalie][:id])
    expect(attempt.goalie[:first_name]).to eq(raw_data[:goalie][:firstName])
    expect(attempt.goalie[:last_name]).to eq(raw_data[:goalie][:lastName])
    expect(attempt.goalie[:jersey_number]).to eq(raw_data[:goalie][:jerseyNumber])
    expect(attempt.goalie[:position]).to eq(raw_data[:goalie][:position])
    expect(attempt.goal?).to eq(raw_data[:isGoal])
    expect(attempt.game_winner?).to eq(raw_data[:isGameWinningGoal])
    expect(attempt.shooting_team[:id]).to eq(raw_data[:shooterTeam][:id])
    expect(attempt.shooting_team[:full_name]).to eq(raw_data[:shooterTeam][:name])
    expect(attempt.shooting_team[:city]).to eq(raw_data[:shooterTeam][:city])
    expect(attempt.shooting_team[:name]).to eq(raw_data[:shooterTeam][:nickname])
    expect(attempt.shooting_team[:abbreviation]).to eq(raw_data[:shooterTeam][:abbreviation])
    expect(attempt.shooting_team[:logo_url]).to eq(raw_data[:shooterTeam][:logo])
  end
end
