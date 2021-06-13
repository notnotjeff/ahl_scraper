# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::Team do
  let(:raw_data) do
    {
      "id": "323",
      "city": "Rochester",
      "team_code": "ROC",
      "name": "Rochester Americans",
      "division_long_name": "North Division",
      "division_short_name": "North",
      "conf_id": "1",
      "logo": "https://assets.leaguestat.com/ahl/logos/323.jpg",
    }
  end

  it "converts raw data into Team record" do
    team = described_class.new(raw_data)

    expect(team.id).to eq(323)
    expect(team.city).to eq("Rochester")
    expect(team.abbreviation).to eq("ROC")
    expect(team.full_name).to eq("Rochester Americans")
    expect(team.name).to eq("Americans")
    expect(team.name).to eq("Americans")
    expect(team.division).to eq("North Division")
    expect(team.conference_id).to eq(1)
    expect(team.logo_url).to eq("https://assets.leaguestat.com/ahl/logos/323.jpg")
  end
end
