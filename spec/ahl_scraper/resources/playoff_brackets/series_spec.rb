# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::Series do
  let(:winning_team) { "384" }
  let(:season_id) { "64" }
  let(:round) { "2" }
  let(:active) { "1" }
  let(:team1_wins) { 4 }
  let(:team2_wins) { 0 }
  let(:raw_data) do
    {
      series_letter: "I",
      series_name: "Atlantic Division Finals",
      series_logo: "",
      round: round,
      active: active,
      feeder_series1: "A",
      feeder_series2: "B",
      team1: "384",
      team2: "319",
      content_en: "",
      content_fr: "",
      winner: winning_team,
      games: [
        {
          game_id: "1019576",
          home_team: "384",
          home_goal_count: "4",
          visiting_team: "319",
          visiting_goal_count: "1",
          status: "4",
          game_status: "Final",
          date_time: "2019-05-03 19:00:00",
          if_necessary: "0",
          game_notes: "",
        },
      ],
      team1_wins: team1_wins,
      team2_wins: team2_wins,
      ties: 0,
    }
  end
  let(:bracket_data) do
    {
      rounds: [
        {
          round: "1",
          round_name: "Round 1",
          season_id: season_id,
          round_type_id: "1",
          round_type_name: "Regular Playoff Series",
          matchups: [],
        },
        {
          round: "2",
          round_name: "Round 2",
          season_id: season_id,
          round_type_id: "2",
          round_type_name: "Regular Playoff Series",
          matchups: [raw_data],
        },
        {
          round: "3",
          round_name: "Round 3",
          season_id: season_id,
          round_type_id: "3",
          round_type_name: "Regular Playoff Series",
          matchups: [],
        },
      ],
    }
  end

  describe "#id" do
    it "returns id" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.id).to eq("I")
    end
  end

  describe "#name" do
    it "returns name" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.name).to eq("Atlantic Division Finals")
    end
  end

  describe "#logo_url" do
    it "returns logo_url" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.logo_url).to be_empty
    end
  end

  describe "#round" do
    it "returns round" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.round).to eq(2)
    end
  end

  describe "#active?" do
    context "when active is 1 in raw data" do
      let(:active) { "1" }
      let(:season_id) { "64" }

      context "when neither team has reached win threshold" do
        let(:team1_wins) { 0 }
        let(:team2_wins) { 0 }

        it "returns true" do
          series = described_class.new(raw_data, { bracket_data: bracket_data })

          expect(series.active?).to be_truthy
        end
      end

      context "when team has reached win threshold" do
        let(:team1_wins) { 4 }
        let(:team2_wins) { 0 }

        it "returns false" do
          series = described_class.new(raw_data, { bracket_data: bracket_data })

          expect(series.active?).to be_falsey
        end
      end
    end

    context "when active is 0 in raw data" do
      let(:active) { "0" }

      it "returns true" do
        series = described_class.new(raw_data, { bracket_data: bracket_data })

        expect(series.active?).to be_falsey
      end
    end
  end

  describe "#home_feeder_series" do
    it "returns A" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.home_feeder_series).to eq("A")
    end
  end

  describe "#away_feeder_series" do
    it "returns B" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.away_feeder_series).to eq("B")
    end
  end

  describe "#winning_team_id" do
    context "when winner is empty" do
      let(:winning_team) { "" }

      context "when no override is needed" do
        let(:season_id) { "64" }

        context "when one team has won" do
          let(:team1_wins) { 0 }
          let(:team2_wins) { 4 }

          it "returns winning_team_id" do
            series = described_class.new(raw_data, { bracket_data: bracket_data })

            expect(series.winning_team_id).to eq(319)
          end
        end

        context "when no team has won" do
          let(:team1_wins) { 0 }
          let(:team2_wins) { 0 }

          it "returns winning_team_id" do
            series = described_class.new(raw_data, { bracket_data: bracket_data })

            expect(series.winning_team_id).to be_nil
          end
        end
      end

      context "when season needs win override" do
        let(:season_id) { "72" }
        let(:round) { "2" }
        let(:team1_wins) { 1 }
        let(:team2_wins) { 0 }

        it "uses new value" do
          series = described_class.new(raw_data, { bracket_data: bracket_data })

          expect(series.winning_team_id).to eq(384)
        end
      end
    end

    context "when winner is not empty" do
      let(:winning_team) { "384" }

      it "returns winning_team_id" do
        series = described_class.new(raw_data, { bracket_data: bracket_data })

        expect(series.winning_team_id).to eq(384)
      end
    end
  end

  describe "#home_team_id" do
    it "returns home_team_id" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.home_team_id).to eq(384)
    end
  end

  describe "#away_team_id" do
    it "returns away_team_id" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.away_team_id).to eq(319)
    end
  end

  describe "#home_team_wins" do
    it "returns home_team_wins" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.home_team_wins).to eq(4)
    end
  end

  describe "#away_team_wins" do
    it "returns away_team_wins" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.away_team_wins).to eq(0)
    end
  end

  describe "#ties" do
    it "returns ties" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.ties).to eq(0)
    end
  end

  describe "#games" do
    it "returns array of playoff bracket game objects" do
      series = described_class.new(raw_data, { bracket_data: bracket_data })

      expect(series.games).to all(be_a(AhlScraper::PlayoffBrackets::Game))
    end
  end
end
