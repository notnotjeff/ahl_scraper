# frozen_string_literal: true

RSpec.describe AhlScraper::PlayoffBrackets::Round do
  let(:raw_data) do
    {
      "round": round,
      "round_name": "Round 1",
      "season_id": "64",
      "round_type_id": "1",
      "round_type_name": "Regular Playoff Series",
      "matchups": [matchup],
    }
  end
  let(:round) { "1" }
  let(:team1_id) { "318" }
  let(:team2_id) { "319" }
  let(:active_series) { "1" }
  let(:matchup) do
    {
      series_letter: "I",
      series_name: "Atlantic Division Finals",
      series_logo: "",
      round: round,
      active: active_series,
      feeder_series1: "A",
      feeder_series2: "B",
      team1: team1_id,
      team2: team2_id,
      content_en: "",
      content_fr: "",
      winner: team1_id,
      games: games,
      team1_wins: "0",
      team2_wins: "0",
      ties: 0,
    }
  end
  let(:games) { [] }

  describe "#id" do
    it "returns id" do
      round = described_class.new(raw_data)

      expect(round.id).to eq(1)
    end
  end

  describe "#name" do
    it "returns name" do
      round = described_class.new(raw_data)

      expect(round.name).to eq("Round 1")
    end
  end

  describe "#season_id" do
    it "returns season_id" do
      round = described_class.new(raw_data)

      expect(round.season_id).to eq(64)
    end
  end

  describe "#round_type_id" do
    it "returns round_type_id" do
      round = described_class.new(raw_data)

      expect(round.round_type_id).to eq(1)
    end
  end

  describe "#round_type_name" do
    it "returns round_type_name" do
      round = described_class.new(raw_data)

      expect(round.round_type_name).to eq("Regular Playoff Series")
    end
  end

  describe "#series" do
    it "returns round_type_name" do
      round = described_class.new(raw_data)

      expect(round.series).to all(be_a(AhlScraper::PlayoffBrackets::Series))
    end
  end

  describe "#active?" do
    let(:series_active) { nil }

    before do
      allow_next_instance_of(AhlScraper::PlayoffBrackets::Series) { |resource| allow(resource).to receive(:active?).and_return(series_active) }
    end

    context "when no series is active" do
      let(:series_active) { false }

      it "returns active? as false" do
        round = described_class.new(raw_data)

        expect(round.active?).to be(false)
      end
    end

    context "when any series is active" do
      let(:series_active) { true }

      it "returns active? as true" do
        round = described_class.new(raw_data)

        expect(round.active?).to be(true)
      end
    end
  end

  describe "#finished?" do
    let(:series_finished) { nil }
    let(:series_active) { nil }

    before do
      allow_next_instance_of(AhlScraper::PlayoffBrackets::Series) do |resource|
        allow(resource).to receive(:finished?).and_return(series_finished)
        allow(resource).to receive(:active?).and_return(series_active)
      end
    end

    context "when no series finished" do
      let(:series_finished) { false }

      it "returns finished? as false" do
        round = described_class.new(raw_data)

        expect(round.finished?).to be(false)
      end
    end

    context "when all series finished" do
      let(:series_finished) { true }

      context "when no active series" do
        let(:series_active) { false }

        it "returns finished? as true" do
          round = described_class.new(raw_data)

          expect(round.finished?).to be(true)
        end
      end

      context "when active series" do
        let(:series_active) { true }

        it "returns finished? as false" do
          round = described_class.new(raw_data)

          expect(round.finished?).to be(false)
        end
      end
    end
  end

  describe "#started?" do
    let(:series_finished) { nil }
    let(:series_active) { nil }

    before do
      allow_next_instance_of(AhlScraper::PlayoffBrackets::Series) do |resource|
        allow(resource).to receive(:finished?).and_return(series_finished)
        allow(resource).to receive(:active?).and_return(series_active)
      end
    end

    context "when round finished" do
      let(:series_finished) { true }
      let(:series_active) { false }

      it "returns started? as true" do
        round = described_class.new(raw_data)

        expect(round.started?).to be(true)
      end
    end

    context "when round active" do
      let(:series_finished) { false }
      let(:series_active) { true }

      it "returns started? as true" do
        round = described_class.new(raw_data)

        expect(round.started?).to be(true)
      end
    end

    context "when neither round finished or active" do
      let(:series_finished) { false }
      let(:series_active) { false }

      it "returns started? as true" do
        round = described_class.new(raw_data)

        expect(round.started?).to be(false)
      end
    end
  end
end
