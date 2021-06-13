# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Referee do
  let(:raw_data) do
    { firstName: "Michael", lastName: "Duco", jerseyNumber: 82, role: "Referee" }
  end

  it "converts raw data to referee record" do
    referee = described_class.new(raw_data)

    expect(referee.first_name).to eq(raw_data[:firstName])
    expect(referee.last_name).to eq(raw_data[:lastName])
    expect(referee.jersey_number).to eq(raw_data[:jerseyNumber])
    expect(referee.role).to eq(raw_data[:role])
  end
end
