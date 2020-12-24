# frozen_string_literal: true

RSpec.describe AhlScraper::Games::Info do
  let(:raw_data) do
    {
      id: 1_019_877,
      date: "Wednesday, November 20, 2019",
      gameNumber: "260",
      venue: "Coca-Cola Coliseum",
      attendance: 4508,
      startTime: "7:08 pm",
      endTime: "9:35 pm",
      duration: "2:27",
      gameReportUrl: "https://lscluster.hockeytech.com/game_reports/official-game-report.php?lang_id=1&client_code=ahl&game_id=1019877",
      textBoxscoreUrl: "https://lscluster.hockeytech.com/game_reports/text-game-report.php?lang_id=1&client_code=ahl&game_id=1019877",
      ticketsUrl: "https://theahl.com/game-tickets",
      started: "1",
      final: "1",
      publicNotes: "",
      status: "Final OT",
      seasonId: "65",
      htvGameId: "407101",
      GameDateISO8601: "2019-11-20T19:00:00-05:00",
    }
  end

  it "converts raw data into Info record" do
    name = "Team 1 @ Team 2"
    info = described_class.new(raw_data, { name: name })

    expect(info.id).to eq(raw_data[:id])
    expect(info.name).to eq(name)
    expect(info.date).to eq(raw_data[:date])
    expect(info.game_number).to eq(raw_data[:gameNumber].to_i)
    expect(info.venue).to eq(raw_data[:venue])
    expect(info.attendance).to eq(raw_data[:attendance])
    expect(info.start_time).to eq(raw_data[:startTime])
    expect(info.end_time).to eq(raw_data[:endTime])
    expect(info.duration).to eq(raw_data[:duration])
    expect(info.game_report_url).to eq(raw_data[:gameReportUrl])
    expect(info.text_boxscore_url).to eq(raw_data[:textBoxscoreUrl])
    expect(info.tickets_url).to eq(raw_data[:ticketsUrl])
    expect(info.started).to eq(raw_data[:started] == "1")
    expect(info.final).to eq(raw_data[:final] == "1")
    expect(info.public_notes).to eq(raw_data[:publicNotes])
    expect(info.status).to eq(raw_data[:status])
    expect(info.season_id).to eq(raw_data[:seasonId].to_i)
    expect(info.htv_game_id).to eq(raw_data[:htvGameId])
    expect(info.datetime).to eq(raw_data[:GameDateISO8601])
  end
end
