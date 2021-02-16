# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Skater do
  let(:raw_data) do
    {
      id: 1234,
      first_name: "Rasmus",
      last_name: "Sandin",
      starting: true,
      captaincy: "C",
      home_team: true,
      faceoff_attempts: 5,
      faceoff_wins: 2,
      hits: 5,
      penalty_minutes: 4,
      shots_as: 3,
      goals_as: 1,
      a1_as: 0,
      a2_as: 0,
      points_as: 0,
      goals_es: 1,
      a1_es: 0,
      a2_es: 0,
      points_es: 0,
      goals_5v5: 0,
      a1_5v5: 0,
      a2_5v5: 0,
      points_5v5: 0,
      goals_pp: 0,
      a1_pp: 0,
      a2_pp: 0,
      points_pp: 0,
    }
  end

  it "converts raw data to Skater record" do
    skater = described_class.new(raw_data)

    expect(skater.first_name).to eq(raw_data[:first_name])
    expect(skater.last_name).to eq(raw_data[:last_name])
    expect(skater.id).to eq(raw_data[:id])
    expect(skater.first_name).to eq(raw_data[:first_name])
    expect(skater.last_name).to eq(raw_data[:last_name])
    expect(skater.team_id).to eq(raw_data[:team_id])
    expect(skater.team_abbreviation).to eq(raw_data[:team_abbreviation])
    expect(skater.starting).to eq(raw_data[:starting])
    expect(skater.captaincy).to eq(raw_data[:captaincy])
    expect(skater.home_team).to eq(raw_data[:home_team])

    expect(skater.stats[:faceoff_wins]).to eq(raw_data[:faceoff_wins])
    expect(skater.stats[:faceoff_attempts]).to eq(raw_data[:faceoff_attempts])
    expect(skater.stats[:hits]).to eq(raw_data[:hits])
    expect(skater.stats[:penalty_minutes]).to eq(raw_data[:penalty_minutes])
    expect(skater.stats[:shots_as]).to eq(raw_data[:shots_as])
    expect(skater.stats[:goals_as]).to eq(raw_data[:goals_as])
    expect(skater.stats[:a1_as]).to eq(raw_data[:a1_as])
    expect(skater.stats[:a2_as]).to eq(raw_data[:a2_as])
    expect(skater.stats[:points_as]).to eq(raw_data[:points_as])
    expect(skater.stats[:goals_es]).to eq(raw_data[:goals_es])
    expect(skater.stats[:a1_es]).to eq(raw_data[:a1_es])
    expect(skater.stats[:a2_es]).to eq(raw_data[:a2_es])
    expect(skater.stats[:points_es]).to eq(raw_data[:points_es])
    expect(skater.stats[:goals_5v5]).to eq(raw_data[:goals_5v5])
    expect(skater.stats[:a1_5v5]).to eq(raw_data[:a1_5v5])
    expect(skater.stats[:a2_5v5]).to eq(raw_data[:a2_5v5])
    expect(skater.stats[:points_5v5]).to eq(raw_data[:points_5v5])
    expect(skater.stats[:goals_pp]).to eq(raw_data[:goals_pp])
    expect(skater.stats[:a1_pp]).to eq(raw_data[:a1_pp])
    expect(skater.stats[:a2_pp]).to eq(raw_data[:a2_pp])
    expect(skater.stats[:points_pp]).to eq(raw_data[:points_pp])
  end
end
