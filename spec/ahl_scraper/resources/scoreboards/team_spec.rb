# frozen_string_literal: true

RSpec.describe AhlScraper::Scoreboards::Team do
  let(:raw_data) do
    {
      id: "413",
      abbreviation: "BEL",
      city: "Belleville",
      name: "Senators",
      full_name: "Belleville Senators",
      division: "North Division",
      audio_url: "https://www.cjbq.com/",
      video_url: "",
      webcasts_url: "http://ahltv.com",
      wins: "2",
      regulation_losses: "5",
      ot_losses: "0",
      shootout_losses: "0",
      logo: "https://assets.leaguestat.com/ahl/logos/50x50/413.png",
    }
  end

  describe "#id" do
    it "returns team id" do
      expect(described_class.new(raw_data).id).to eq(413)
    end
  end

  describe "#abbreviation" do
    it "returns team abbreviation" do
      expect(described_class.new(raw_data).abbreviation).to eq("BEL")
    end
  end

  describe "#city" do
    it "returns team city" do
      expect(described_class.new(raw_data).city).to eq("Belleville")
    end
  end

  describe "#name" do
    it "returns team name" do
      expect(described_class.new(raw_data).name).to eq("Senators")
    end
  end

  describe "#full_name" do
    it "returns team's full name" do
      expect(described_class.new(raw_data).full_name).to eq("Belleville Senators")
    end
  end

  describe "#division" do
    it "returns division name team belongs to" do
      expect(described_class.new(raw_data).division).to eq("North Division")
    end
  end

  describe "#audio_url" do
    it "returns url to the audio for the game" do
      expect(described_class.new(raw_data).audio_url).to eq("https://www.cjbq.com/")
    end
  end

  describe "#video_url" do
    it "returns url to the video for the game" do
      expect(described_class.new(raw_data).video_url).to eq("")
    end
  end

  describe "#webcasts_url" do
    it "returns url for the webcasts for the game" do
      expect(described_class.new(raw_data).webcasts_url).to eq("http://ahltv.com")
    end
  end

  describe "#wins" do
    it "returns the team's wins" do
      expect(described_class.new(raw_data).wins).to eq(2)
    end
  end

  describe "#regulation_losses" do
    it "returns the team's regulation losses" do
      expect(described_class.new(raw_data).regulation_losses).to eq(5)
    end
  end

  describe "#ot_losses" do
    it "returns the teams OT losses" do
      expect(described_class.new(raw_data).ot_losses).to eq(0)
    end
  end

  describe "#shootout_losses" do
    it "returns the team's shootout losses" do
      expect(described_class.new(raw_data).shootout_losses).to eq(0)
    end
  end
end
