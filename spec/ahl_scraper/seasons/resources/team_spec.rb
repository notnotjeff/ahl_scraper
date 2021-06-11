# frozen_string_literal: true

RSpec.describe AhlScraper::Seasons::Team do
  let(:raw_data) do
    {
      prop: {
        team_code: { teamLink: "411" },
        name: { teamLink: "411" },
      },
      row: {
        team_code: "SPR",
        wins: "32",
        losses: "37",
        ot_losses: "5",
        shootout_losses: "2",
        regulation_wins: "27",
        row: "30",
        points: "71",
        penalty_minutes: "1088",
        streak: "0-3-0-0",
        goals_for: "210",
        goals_against: "233",
        percentage: "0.467",
        overall_rank: "25",
        games_played: "76",
        rank: 7,
        past_10: "4-5-0-1",
        name: "Springfield Thunderbirds",
      },
    }
  end

  let(:division) { "Atlantic" }

  describe "#call" do
    it "returns Team object" do
      team = described_class.new(raw_data, division)

      expect(team.id).to eq(411)
      expect(team.full_name).to eq("Springfield Thunderbirds")
      expect(team.city).to eq("Springfield")
      expect(team.name).to eq("Thunderbirds")
      expect(team.abbreviation).to eq("SPR")
      expect(team.division).to eq(division)
      expect(team.game_file_city).to be_nil
    end

    context "when team has three words in full name" do
      let(:raw_data) do
        {
          prop: {
            team_code: { teamLink: "313" },
            name: { teamLink: "313" },
          },
          row: {
            team_code: "LV",
            wins: "47",
            losses: "19",
            ot_losses: "5",
            shootout_losses: "5",
            regulation_wins: "40",
            row: "44",
            points: "104",
            penalty_minutes: "840",
            streak: "3-0-1-0",
            goals_for: "260",
            goals_against: "218",
            percentage: "0.684",
            overall_rank: "2",
            games_played: "76",
            rank: 1,
            past_10: "5-3-2-0",
            name: "Lehigh Valley Phantoms",
          },
        }
      end

      it "returns Team object" do
        team = described_class.new(raw_data, division)

        expect(team.id).to eq(313)
        expect(team.full_name).to eq("Lehigh Valley Phantoms")
        expect(team.city).to eq("Lehigh Valley")
        expect(team.name).to eq("Phantoms")
        expect(team.abbreviation).to eq("LV")
        expect(team.division).to eq(division)
        expect(team.game_file_city).to be_nil
      end
    end

    context "when team has clinched letter in name" do
      let(:raw_data) do
        {
          prop: {
            team_code: { teamLink: "313" },
            name: { teamLink: "313" },
          },
          row: {
            team_code: "y - LV",
            wins: "47",
            losses: "19",
            ot_losses: "5",
            shootout_losses: "5",
            regulation_wins: "40",
            row: "44",
            points: "104",
            penalty_minutes: "840",
            streak: "3-0-1-0",
            goals_for: "260",
            goals_against: "218",
            percentage: "0.684",
            overall_rank: "2",
            games_played: "76",
            rank: 1,
            past_10: "5-3-2-0",
            name: "y - Lehigh Valley Phantoms",
          },
        }
      end

      it "returns Team object" do
        team = described_class.new(raw_data, division)

        expect(team.id).to eq(313)
        expect(team.full_name).to eq("Lehigh Valley Phantoms")
        expect(team.city).to eq("Lehigh Valley")
        expect(team.name).to eq("Phantoms")
        expect(team.abbreviation).to eq("LV")
        expect(team.division).to eq(division)
        expect(team.game_file_city).to be_nil
      end
    end
  end
end
