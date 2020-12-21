# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Team do
  let(:raw_data) do
    {
      info: { id: 373, name: "Cleveland Monsters", city: "Cleveland", nickname: "Monsters", abbreviation: "CLE", logo: "https://assets.leaguestat.com/ahl/logos/373_61.jpg" },
      stats: { goals: 4, hits: 0, powerPlayGoals: 0, powerPlayOpportunities: 3, goalCount: 4, assistCount: 4, penaltyMinuteCount: 7, infractionCount: 2 },
    }
  end

  it "converts raw data into attributes" do
    team = described_class.new(raw_data, { home_team: true })

    expect(team.id).to eq(raw_data[:info][:id])
    expect(team.full_name).to eq(raw_data[:info][:name])
    expect(team.city).to eq(raw_data[:info][:city])
    expect(team.name).to eq(raw_data[:info][:nickname])
    expect(team.abbreviation).to eq(raw_data[:info][:abbreviation])
    expect(team.logo_url).to eq(raw_data[:info][:logo])
    expect(team.stats[:goals]).to eq(raw_data[:stats][:goals])
    expect(team.stats[:hits]).to eq(raw_data[:stats][:hits])
    expect(team.stats[:power_play_goals]).to eq(raw_data[:stats][:powerPlayGoals])
    expect(team.stats[:power_play_opportunities]).to eq(raw_data[:stats][:powerPlayOpportunities])
    expect(team.stats[:goal_count]).to eq(raw_data[:stats][:goalCount])
    expect(team.stats[:assist_count]).to eq(raw_data[:stats][:assisCount])
    expect(team.stats[:penalty_minute_count]).to eq(raw_data[:stats][:penaltyMinuteCount])
    expect(team.stats[:infraction_count]).to eq(raw_data[:stats][:infractionCount])
  end

  context "when away team" do
    it "sets home_team? to false" do
      team = described_class.new(raw_data, { home_team: false })

      expect(team.home_team?).to eq(false)
    end
  end

  context "when home team" do
    it "sets home_team? to true" do
      team = described_class.new(raw_data, { home_team: true })

      expect(team.home_team?).to eq(true)
    end
  end
end
