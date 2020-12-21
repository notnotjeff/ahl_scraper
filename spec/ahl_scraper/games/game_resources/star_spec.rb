# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Star do
  let(:raw_data) do
    {
      team: { id: 373, name: "Cleveland Monsters", city: "Cleveland", nickname: "Monsters", abbreviation: "CLE", logo: "https://assets.leaguestat.com/ahl/logos/373_61.jpg" },
      player: {
        info: { id: 7025, firstName: "Kevin", lastName: "Stenlund", jerseyNumber: 82, position: "C", birthDate: "1996-09-20" },
        stats: { goals: 1, assists: 0, points: 1, penaltyMinutes: 0, plusMinus: 1, faceoffAttempts: 0, faceoffWins: 0, shots: 3, hits: 0 }, starting: 1, status: "",
      },
      isGoalie: false,
      playerImage: "https://assets.leaguestat.com/ahl/240x240/7025.jpg",
    }
  end

  it "converts raw data into Star record" do
    star = described_class.new(raw_data, { number: 1 })

    expect(star.id).to eq(raw_data[:player][:id])
    expect(star.first_name).to eq(raw_data[:player][:firstName])
    expect(star.last_name).to eq(raw_data[:player][:lastName])
    expect(star.team_id).to eq(raw_data[:team][:id])
    expect(star.jersey_name).to eq(raw_data[:player][:jerseyNumber])
    expect(star.position).to eq(raw_data[:player][:position])
    expect(star.birthdate).to eq(raw_data[:player][:birthDate])
    expect(star.goalie?).to eq(raw_data[:isGoalie])
    expect(star.image_url).to eq(raw_data[:playerImage])
  end
end
