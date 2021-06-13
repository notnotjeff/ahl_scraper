# frozen_string_literal: true

RSpec.describe AhlScraper::Player do
  let(:raw_data) do
    {
      info: {
        jerseyNumber: "5",
        firstName: "Urho",
        lastName: "Vaakanainen",
        playerId: "7446",
        personId: "7527",
        position: "D",
        shoots: "L",
        catches: "R",
        height: "6-1",
        height_sans_hyphen: "6.1",
        height_hyphenated: "6-1",
        weight: "185",
        birthDate: "1999-01-01",
        profileImage: "https://assets.leaguestat.com/ahl/240x240/7446.jpg",
        teamImage: "https://assets.leaguestat.com/ahl/logos/309.jpg",
        bio: "",
        teamName: "Providence Bruins",
        division: "Atlantic Division",
        commitment: false,
        currentTeam: "",
        suspension_games_remaining: "",
        birthPlace: "Joensuu, Finland ",
        playerType: "skater",
      },
    }
  end

  it "creates a new player object" do
    mocked_age = 100
    allow_next_instance_of(AhlScraper::BirthdateHelper) do |helper|
      allow(helper).to receive(:current_age).and_return(mocked_age)
    end

    player = described_class.new(raw_data)

    expect(player.current_age).to eq(mocked_age)
    expect(player.weight).to eq(185)
    expect(player.id).to eq(7446)
    expect(player.catches).to eq("R")
    expect(player.position).to eq("D")
    expect(player.first_name).to eq("Urho")
    expect(player.last_name).to eq("Vaakanainen")
    expect(player.jersey_number).to eq(5)
    expect(player.birthdate).to eq("1999-01-01")
    expect(player.shoots).to eq("L")
    expect(player.birthplace).to eq("Joensuu, Finland")
    expect(player.height).to eq("6-1")
    expect(player.draft_year).to eq(2016)
  end
end
