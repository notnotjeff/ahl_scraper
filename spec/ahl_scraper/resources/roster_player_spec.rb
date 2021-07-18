# frozen_string_literal: true

RSpec.describe AhlScraper::RosterPlayer do
  let(:is_rookie) { "0" }
  let(:team_id) { 335 }
  let(:season_id) { 61 }
  let(:raw_data) do
    {
      bio: {
        prop: {
          name: { playerLink: "7363", seoName: "Aaron Luchuk" },
        },
        row: { shoots: "L", birthplace: "Kingston, ON", height_hyphenated: "5-10", player_id: "7363", birthdate: "1997-04-04", tp_jersey_number: "9", position: "C", w: "186", name: "Aaron Luchuk" },
      },
      stats: {
        prop: {
          name: { playerLink: "7363", seoName: "Aaron Luchuk" },
          rookie: { rookie: is_rookie }, team_code: { teamLink: "335" },
        },
        row: {
          player_id: "7363",
          name: "Aaron Luchuk",
          position: "C",
          rookie: "0",
          team_code: "TOR",
          games_played: "3",
          goals: "0",
          shots: "0",
          assists: "0",
          points: "0",
          points_per_game: "0.00",
          plus_minus: "-1",
          penalty_minutes: "0",
          penalty_minutes_per_game: "0.00",
          power_play_goals: "0",
          short_handed_goals: "0",
          shootout_goals: "0",
          shootout_attempts: "0",
          shootout_winning_goals: "0",
          shootout_percentage: "0.0",
          rank: 50,
        },
      },
    }
  end

  context "when player is a skater" do
    it "converts raw data into RosterPlayer object" do
      skater = described_class.new(raw_data, team_id, season_id)

      expect(skater.id).to eq(raw_data[:bio][:row][:player_id].to_i)
      expect(skater.name).to eq(raw_data[:bio][:row][:name])
      expect(skater.handedness).to eq(raw_data[:bio][:row][:shoots])
      expect(skater.birthplace).to eq(raw_data[:bio][:row][:birthplace])
      expect(skater.height).to eq(raw_data[:bio][:row][:height_hyphenated])
      expect(skater.birthdate).to eq(raw_data[:bio][:row][:birthdate])
      expect(skater.jersey_number).to eq(raw_data[:bio][:row][:tp_jersey_number].to_i)
      expect(skater.position).to eq(raw_data[:bio][:row][:position])
      expect(skater.weight).to eq(raw_data[:bio][:row][:w].to_i)
      expect(skater.rookie?).to eq(false)
    end
  end

  context "when player is a rookie" do
    let(:is_rookie) { "1" }

    it "sets rookie? to true" do
      player = described_class.new(raw_data, team_id, season_id)

      expect(player.rookie?).to eq(true)
    end
  end

  context "when player is goalie" do
    let(:raw_data) do
      {
        bio: {
          prop: { name: { playerLink: "7399", seoName: "Stuart Skinner" } },
          row: {
            catches: "R",
            birthplace: "Edmonton, AB",
            height_hyphenated: "6-3",
            player_id: "7399",
            birthdate: "1998-11-01",
            tp_jersey_number: "34",
            position: "G",
            w: "203",
            name: "Stuart Skinner",
          },
        },
        stats: {
          prop: {
            rookie: { rookie: "0" },
            name: { playerLink: "7399", seoName: "Stuart Skinner" },
            active: { active: "1" },
            team_code: { teamLink: "402" },
          },
          row: {
            player_id: "7399",
            rookie: "0",
            name: "Stuart Skinner",
            active: "1",
            team_code: "BAK",
            games_played: "31",
            minutes_played: "1786:59",
            saves: "753",
            shots: "824",
            save_percentage: "0.914",
            goals_against: "71",
            shutouts: "2",
            wins: "20",
            losses: "9",
            ot_losses: "1",
            shootout_goals_against: "3",
            shootout_attempts: "6",
            shootout_percentage: "0.500",
            goals_against_average: "2.38",
            rank: 1,
          },
        },
      }
    end

    it "converts raw data to RosterPlayer object" do
      goalie = described_class.new(raw_data, team_id, season_id)

      expect(goalie.id).to eq(raw_data[:bio][:row][:player_id].to_i)
      expect(goalie.name).to eq(raw_data[:bio][:row][:name])
      expect(goalie.handedness).to eq(raw_data[:bio][:row][:catches])
      expect(goalie.birthplace).to eq(raw_data[:bio][:row][:birthplace])
      expect(goalie.height).to eq(raw_data[:bio][:row][:height_hyphenated])
      expect(goalie.birthdate).to eq(raw_data[:bio][:row][:birthdate])
      expect(goalie.jersey_number).to eq(raw_data[:bio][:row][:tp_jersey_number].to_i)
      expect(goalie.position).to eq(raw_data[:bio][:row][:position])
      expect(goalie.weight).to eq(raw_data[:bio][:row][:w].to_i)
      expect(goalie.rookie?).to eq(false)
    end
  end
end
