# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Skater do
  let(:raw_data) do
    {
      id: 1234,
      first_name: "Rasmus",
      last_name: "Sandin",
      number: 8,
      starting: true,
      captaincy: "C",
      home_team: true,
      faceoff_attempts: 5,
      faceoff_wins: 2,
      hits: 5,
      penalty_minutes: 4,
      birthdate: "2000-03-14",
    }
  end
  let(:on_ice) do
    {
      gf_as: 3,
      ga_as: 2,
    }
  end
  let(:penalty) do
    {
      minors: 3,
    }
  end
  let(:shootout) do
    {
      attempts: 1,
    }
  end
  let(:penalty_shot) do
    {
      attempts: 1,
    }
  end
  let(:scoring) do
    {
      goals_as: 1,
      a1_as: 0,
      a2_as: 0,
    }
  end

  it "converts raw data to Skater record" do
    skater = described_class.new(
      raw_data,
      { scoring_statline: scoring, on_ice_statline: on_ice, penalty_statline: penalty, penalty_shot_statline: penalty_shot, shootout_statline: shootout, game_date: "Saturday, December 28, 2019" }
    )

    expect(skater.first_name).to eq(raw_data[:first_name])
    expect(skater.last_name).to eq(raw_data[:last_name])
    expect(skater.id).to eq(raw_data[:id])
    expect(skater.first_name).to eq(raw_data[:first_name])
    expect(skater.last_name).to eq(raw_data[:last_name])
    expect(skater.jersey_number).to eq(raw_data[:number])
    expect(skater.birthdate).to eq(raw_data[:birthdate])
    expect(skater.current_age.to_f).to eq(19.8)
    expect(skater.team_id).to eq(raw_data[:team_id])
    expect(skater.team_abbreviation).to eq(raw_data[:team_abbreviation])
    expect(skater.starting).to eq(raw_data[:starting])
    expect(skater.captaincy).to eq(raw_data[:captaincy])
    expect(skater.home_team).to eq(raw_data[:home_team])

    expect(skater.stats[:faceoff_wins]).to eq(raw_data[:faceoff_wins])
    expect(skater.stats[:faceoff_attempts]).to eq(raw_data[:faceoff_attempts])
    expect(skater.stats[:hits]).to eq(raw_data[:hits])
    expect(skater.stats[:penalty_minutes]).to eq(raw_data[:penalty_minutes])
    expect(skater.shots[:sog_as]).to eq(raw_data[:sog_as])
    expect(skater.scoring).to eq(scoring)
    expect(skater.on_ice).to eq(on_ice)
    expect(skater.penalty).to eq(penalty)
    expect(skater.penalty_shot).to eq(penalty_shot)
    expect(skater.shootout).to eq(shootout)
  end
end
