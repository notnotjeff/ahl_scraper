# frozen_string_literal: true

RSpec.describe AhlScraper::Players::DraftInfo do
  let(:raw_data) do
    {
      id: "111157",
      draft_league: "NHL",
      draft_team: "Toronto Maple Leafs",
      draft_team_id: "28",
      draft_year: "2019",
      draft_round: "2",
      draft_rank: "53",
      draft_junior_team: "Peterborough (OHL)",
      draft_logo: "https:\/\/assets.leaguestat.com\/leaguestat\/nhlLogos\/toronto.png",
      draft_logo_caption: "Toronto Maple Leafs",
      show_on_roster: "1",
      draft_text: " Toronto Maple Leafs - Drafted: 2019, Round: 2 (#53)",
    }
  end

  it "converts raw data into DraftInfo record" do
    draft_info = described_class.new(raw_data)

    expect(draft_info.id).to eq(111_157)
    expect(draft_info.league).to eq("NHL")
    expect(draft_info.team_name).to eq("Toronto Maple Leafs")
    expect(draft_info.team_id).to eq(28)
    expect(draft_info.year).to eq(2019)
    expect(draft_info.round).to eq(2)
    expect(draft_info.rank).to eq(53)
    expect(draft_info.junior_team).to eq("Peterborough (OHL)")
    expect(draft_info.team_logo).to eq("https:\/\/assets.leaguestat.com\/leaguestat\/nhlLogos\/toronto.png")
    expect(draft_info.description).to eq("Toronto Maple Leafs - Drafted: 2019, Round: 2 (#53)")
  end
end
