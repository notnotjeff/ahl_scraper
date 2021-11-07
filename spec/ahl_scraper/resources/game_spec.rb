# frozen_string_literal: true

RSpec.describe AhlScraper::Game do
  describe "#game_id", :vcr do
    it "returns game id" do
      game = described_class.new(1_018_340)
      expect(game.game_id).to eq(1_018_340)
    end
  end

  describe "#status", :vcr do
    context "when game has ended" do
      it "returns finished" do
        game = described_class.new(1_018_340)

        expect(game.status).to eq("finished")
      end
    end

    context "when game has been postponed" do
      it "returns postponed" do
        game = described_class.new(1_022_727)

        expect(game.status).to eq("postponed")
      end
    end

    context "when game result needs to be voided" do
      it "returns result_void" do
        game = described_class.new(1_022_174)

        expect(game.status).to eq("result_void")
      end
    end
  end

  describe "#info", :vcr do
    it "returns game info" do
      game = described_class.new(1_018_340)
      expect(game.info[:game_number]).to eq(2)
    end
  end

  describe "#season_id", :vcr do
    it "returns season id" do
      game = described_class.new(1_018_340)
      expect(game.season_id).to eq(61)
    end
  end

  describe "#season_type", :vcr do
    context "when game is regular season" do
      it "returns :regular" do
        game = described_class.new(1_018_340)
        expect(game.season_type).to eq(:regular)
      end
    end

    context "when game is playoffs" do
      it "returns :playoffs" do
        game = described_class.new(1_019_569)
        expect(game.season_type).to eq(:playoffs)
      end
    end

    context "when all-star game" do
      it "returns :all_star" do
        game = described_class.new(1_019_521)
        expect(game.season_type).to eq(:all_star)
      end
    end

    context "when game is exhibition" do
      it "returns :exhibition" do
        game = described_class.new(1_012_246)
        expect(game.season_type).to eq(:exhibition)
      end
    end
  end

  describe "#referees", :vcr do
    it "returns referees" do
      game = described_class.new(1_018_340)
      expect(game.referees.map(&:last_name)).to match_array(%w[Duco MacDougall Baker King])
    end
  end

  describe "#home_coaches", :vcr do
    it "returns coaches" do
      game = described_class.new(1_018_340)
      expect(game.home_coaches.map(&:last_name)).to match_array(%w[Madden McCarthy])
    end

    context "when duplicate coach is in array" do
      it "only shows unique coaches" do
        game = described_class.new(1_015_979)
        expect(game.home_coaches.map(&:last_name)).to match_array(%w[Andersson Samuelsson])
      end
    end
  end

  describe "#away_coaches", :vcr do
    it "returns coaches" do
      game = described_class.new(1_018_340)
      expect(game.away_coaches.map(&:last_name)).to match_array(%w[Colliton Brookbank King])
    end
  end

  describe "#home_team", :vcr do
    it "returns team" do
      game = described_class.new(1_018_340)
      expect(game.home_team.id).to eq(373)
    end

    context "when game sets nickname to city" do
      it "returns nickname from removing city from name field" do
        game = described_class.new(1_012_612)
        expect(game.home_team.name).to eq("Wolf Pack")
      end
    end
  end

  describe "#away_team", :vcr do
    it "returns team" do
      game = described_class.new(1_018_340)
      expect(game.away_team.id).to eq(372)
    end
  end

  describe "#winning_team", :vcr do
    it "returns winning team" do
      game = described_class.new(1_018_340)
      expect(game.winning_team.id).to eq(373)
    end
  end

  describe "#three_stars", :vcr do
    it "returns three stars" do
      game = described_class.new(1_018_340)
      expect(game.three_stars.map(&:id)).to match_array([7025, 7442, 3621])
    end
  end

  describe "#home_skaters", :vcr do
    it "returns skaters" do
      game = described_class.new(1_018_340)
      expect(game.home_skaters.map(&:id)).to eq([4553, 6725, 6727, 5612, 7442, 6384, 6636, 7226, 4982, 6887, 6889, 3543, 6957, 6349, 5939, 7025, 6699, 2630])
    end
  end

  describe "#away_skaters", :vcr do
    it "returns skaters" do
      game = described_class.new(1_018_340)
      expect(game.away_skaters.map(&:id)).to eq([2507, 6632, 5692, 6861, 3555, 7432, 4452, 6914, 7430, 7434, 6862, 6863, 5839, 5930, 7055, 7046, 6629, 6864])
    end
  end

  describe "#home_goalies", :vcr do
    it "returns goalies" do
      game = described_class.new(1_018_340)
      expect(game.home_goalies.map(&:id)).to eq([3621, 3145])
    end
  end

  describe "#away_goalies", :vcr do
    it "returns goalies" do
      game = described_class.new(1_018_340)
      expect(game.away_goalies.map(&:id)).to eq([7431, 6948])
    end
  end

  describe "#goals", :vcr do
    it "returns goals" do
      game = described_class.new(1_018_340)
      expect(game.goals.map { |g| g.scored_by[:id] }).to eq([6861, 7442, 7025, 6727, 6384])
    end
  end

  describe "#penalties", :vcr do
    it "returns penalties" do
      game = described_class.new(1_018_340)
      expect(game.penalties.map { |g| g.served_by[:id] }).to eq([7432, 6862, 6864, 6914, 6889, 3543])
    end
  end

  describe "#penalty_shots", :vcr do
    it "returns penalty shots" do
      game = described_class.new(1_018_452)
      expect(game.penalty_shots.map { |s| s[:shooter][:id] }).to eq([6814])
    end
  end

  describe "#periods", :vcr do
    it "returns periods" do
      game = described_class.new(1_018_340)
      expect(game.periods.map(&:number)).to eq([1, 2, 3])
    end
  end

  describe "#overtimes", :vcr do
    it "it returns overtime periods" do
      game = described_class.new(1_019_877)
      game.home_team.goal_stats
      expect(game.overtimes.map(&:number)).to eq([1])
    end
  end

  describe "#overtime", :vcr do
    context "when game does not go to overtime" do
      it "returns false" do
        game = described_class.new(1_018_340)
        expect(game.overtime?).to eq(false)
      end
    end

    context "when game goes to overtime" do
      it "returns true" do
        game = described_class.new(1_019_877)
        expect(game.overtime?).to eq(true)
      end
    end
  end

  describe "#home_shootout_attempts", :vcr do
    it "returns no shootout attempts" do
      game = described_class.new(1_019_976)

      expect(game.home_shootout_attempts.map { |att| att.shooter[:id] }).to match_array([4632, 7101, 4552])
    end
  end

  describe "#away_shootout_attempts", :vcr do
    it "returns shootout attempts" do
      game = described_class.new(1_019_976)
      expect(game.away_shootout_attempts.map { |att| att.shooter[:id] }).to match_array([5834, 7575, 134])
    end
  end

  describe "#shootout", :vcr do
    context "when game does not go to shootout" do
      it "returns false" do
        game = described_class.new(1_018_340)
        expect(game.shootout?).to eq(false)
      end
    end

    context "when game has shootout" do
      it "returns true" do
        game = described_class.new(1_019_976)
        expect(game.shootout?).to eq(true)
      end
    end
  end

  describe "#current_time", :vcr do
    context "when game has not started" do
      it "returns nil" do
        game = described_class.new(1_023_743)
        expect(game.current_time).to be_nil
      end
    end

    context "when game is finished" do
      it "returns nil" do
        game = described_class.new(1_018_340)
        expect(game.current_time).to be_nil
      end
    end
  end
end
