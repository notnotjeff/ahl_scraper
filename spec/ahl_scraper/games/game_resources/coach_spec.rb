# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Coach do
  let(:raw_data) do
    { firstName: "Dallas", lastName: "Eakins", role: "Head Coach" }
  end

  it "converts raw data into Coach record" do
    team_id = 1
    coach = described_class.new(raw_data, { team_id: team_id })

    expect(coach.first_name).to eq(raw_data[:firstName])
    expect(coach.last_name).to eq(raw_data[:lastName])
    expect(coach.role).to eq(raw_data[:role])
    expect(coach.team_id).to eq(team_id)
  end
end
