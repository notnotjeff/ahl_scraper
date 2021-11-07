# frozen_string_literal: true

RSpec.describe AhlScraper::Scoreboard do
  let(:raw_data) do
    {
      ID: "1022691",
      SeasonID: "73",
      game_number: "66",
      game_letter: "",
      game_type: "",
      quick_score: "0",
      Date: "2021-10-27",
      HtvGameID: "950020",
      GameDate: "Wed, Oct 27",
      GameDateISO8601: "2021-10-27T19:00:00-04:00",
      ScheduledTime: "19:00:00",
      ScheduledFormattedTime: "7:00 pm",
      Timezone: "Canada/Eastern",
      TicketUrl: "",
      HomeID: "413",
      HomeCode: "BEL",
      HomeCity: "Belleville",
      HomeNickname: "Senators",
      HomeLongName: "Belleville Senators",
      HomeDivision: "North Division",
      HomeGoals: "7",
      HomeAudioUrl: "https://www.cjbq.com/",
      HomeVideoUrl: "",
      HomeWebcastUrl: "http://ahltv.com",
      VisitorID: "323",
      VisitorCode: "ROC",
      VisitorCity: "Rochester",
      VisitorNickname: "Americans",
      VisitorLongName: "Rochester Americans",
      VisitingDivision: "North Division",
      VisitorGoals: "3",
      VisitorAudioUrl: "https://www.audacy.com/espnrochester",
      VisitorVideoUrl: "",
      VisitorWebcastUrl: "http://ahltv.com",
      Period: "3",
      PeriodNameShort: "3",
      PeriodNameLong: "3rd",
      GameClock: "00:00",
      GameSummaryUrl: "1022691",
      HomeWins: "2",
      HomeRegulationLosses: "5",
      HomeOTLosses: "0",
      HomeShootoutLosses: "0",
      VisitorWins: "4",
      VisitorRegulationLosses: "2",
      VisitorOTLosses: "0",
      VisitorShootoutLosses: "0",
      GameStatus: "4",
      Intermission: intermission,
      GameStatusString: "Final",
      GameStatusStringLong: "Final",
      Ord: "2021-10-27 19:00:00.000000",
      venue_name: "CAA Arena",
      venue_location: "Belleville, ON",
      league_name: "American Hockey League",
      league_code: "ahl",
      TimezoneShort: "EDT",
      HomeLogo: "https://assets.leaguestat.com/ahl/logos/50x50/413.png",
      VisitorLogo: "https://assets.leaguestat.com/ahl/logos/50x50/323_73.png",
    }
  end
  let(:intermission) { "0" }

  describe "#id" do
    it "returns game id" do
      expect(described_class.new(raw_data).id).to eq(1_022_691)
    end
  end

  describe "#season_id" do
    it "returns season id" do
      expect(described_class.new(raw_data).season_id).to eq(73)
    end
  end

  describe "#game_number" do
    it "returns game number" do
      expect(described_class.new(raw_data).game_number).to eq(66)
    end
  end

  describe "#game_date" do
    it "returns date YYYY-MM-DD" do
      expect(described_class.new(raw_data).game_date).to eq("2021-10-27")
    end
  end

  describe "#htv_game_id" do
    it "returns HTV game id" do
      expect(described_class.new(raw_data).htv_game_id).to eq(950_020)
    end
  end

  describe "#game_date_words" do
    it "returns game date in words" do
      expect(described_class.new(raw_data).game_date_words).to eq("Wed, Oct 27")
    end
  end

  describe "#game_date_ISO8601" do
    it "returns game date in ISO8601" do
      expect(described_class.new(raw_data).game_date_ISO8601).to eq("2021-10-27T19:00:00-04:00")
    end
  end

  describe "#scheduled_time" do
    it "returns start time in military clock" do
      expect(described_class.new(raw_data).scheduled_time).to eq("19:00:00")
    end
  end

  describe "#scheduled_time_formatted" do
    it "returns game time in 12 hour clock" do
      expect(described_class.new(raw_data).scheduled_time_formatted).to eq("7:00 pm")
    end
  end

  describe "#timezone" do
    it "returns timezone full string" do
      expect(described_class.new(raw_data).timezone).to eq("Canada/Eastern")
    end
  end

  describe "#ticket_url" do
    it "returns the tickets url for the game" do
      expect(described_class.new(raw_data).ticket_url).to eq("")
    end
  end

  describe "#period" do
    it "returns the current or final period" do
      expect(described_class.new(raw_data).period).to eq(3)
    end
  end

  describe "#period_long_name" do
    it "returns current or final period with suffix" do
      expect(described_class.new(raw_data).period_long_name).to eq("3rd")
    end
  end

  describe "#game_clock" do
    it "returns current or final time left in the game" do
      expect(described_class.new(raw_data).game_clock).to eq("00:00")
    end
  end

  describe "#intermission?" do
    context "when not intermission" do
      let(:intermission) { "0" }

      it "returns false" do
        expect(described_class.new(raw_data).intermission?).to be_falsey
      end
    end

    context "when intermission" do
      let(:intermission) { "1" }

      it "returns true" do
        expect(described_class.new(raw_data).intermission?).to be_truthy
      end
    end
  end

  describe "#game_status" do
    it "returns game status" do
      expect(described_class.new(raw_data).game_status).to eq("Final")
    end
  end

  describe "#game_status_string_long" do
    it "returns long version of game status" do
      expect(described_class.new(raw_data).game_status_string_long).to eq("Final")
    end
  end

  describe "#venue_name" do
    it "returns venue name" do
      expect(described_class.new(raw_data).venue_name).to eq("CAA Arena")
    end
  end

  describe "#venue_location" do
    it "returns venue location" do
      expect(described_class.new(raw_data).venue_location).to eq("Belleville, ON")
    end
  end

  describe "#timezone_short" do
    it "returns timezone short form" do
      expect(described_class.new(raw_data).timezone_short).to eq("EDT")
    end
  end

  describe "#home_team" do
    it "returns Team resource for home team" do
      expect(described_class.new(raw_data).home_team).to be_a(AhlScraper::Scoreboards::Team)
    end
  end

  describe "#home_score" do
    it "returns home score in the game" do
      expect(described_class.new(raw_data).home_score).to eq(7)
    end
  end

  describe "#away_team" do
    it "returns Team resource for away team" do
      expect(described_class.new(raw_data).away_team).to be_a(AhlScraper::Scoreboards::Team)
    end
  end

  describe "#away_score" do
    it "returns away score in game" do
      expect(described_class.new(raw_data).away_score).to eq(3)
    end
  end
end
