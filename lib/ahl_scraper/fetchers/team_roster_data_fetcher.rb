# frozen_string_literal: true

module AhlScraper
  class TeamRosterDataFetcher
    def initialize(team_id, season_id)
      @team_id = team_id
      @season_id = season_id
    end

    def call
      fetch_roster_data
      merge_positional_data
      merge_roster_data
      merge_all_data
    end

    private

    def fetch_roster_data
      @roster_data = JSON.parse(Nokogiri::HTML(URI.parse(roster_url).open).text[5..-2], symbolize_names: true)
    end

    def forward_data
      @forward_data ||= JSON.parse(Nokogiri::HTML(URI.parse(forwards_url).open).text[5..-2], symbolize_names: true).dig(0, :sections, 0, :data)
    end

    def defencemen_data
      @defencemen_data ||= JSON.parse(Nokogiri::HTML(URI.parse(defencemen_url).open).text[5..-2], symbolize_names: true).dig(0, :sections, 0, :data)
    end

    def goalie_data
      @goalie_data ||= JSON.parse(Nokogiri::HTML(URI.parse(goalies_url).open).text[5..-2], symbolize_names: true).dig(0, :sections, 0, :data)
    end

    def merge_roster_data
      @player_data = @roster_data.dig(:roster, 0, :sections)[0..2].map { |players| players[:data] }.flatten
    end

    def merge_positional_data
      @positional_data = (forward_data + defencemen_data + goalie_data).filter { |player| !player[:row][:player_id].nil? }
        .map { |player| [player[:row][:player_id], player] }
        .to_h
    end

    def merge_all_data
      @player_bio_data = @player_data.map do |player|
        { bio: player, stats: @positional_data[player[:row][:player_id]] }
      end
    end

    def roster_url
      "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=roster&team_id=#{@team_id}&season_id=#{@season_id}&key=50c2cd9b5e18e390&client_code=ahl&site_id=3&league_id=4&lang=en&callback=json" # rubocop:disable Layout/LineLength
    end

    def forwards_url
      "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=players&season=#{@season_id}&team=#{@team_id}&position=skaters&rookies=0&statsType=standard&rosterstatus=undefined&site_id=3&first=0&limit=20&sort=points&league_id=4&lang=en&division=-1&key=50c2cd9b5e18e390&client_code=ahl&league_id=4&callback=json" # rubocop:disable Layout/LineLength
    end

    def defencemen_url
      "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=players&season=#{@season_id}&team=#{@team_id}&position=defencemen&rookies=0&statsType=standard&rosterstatus=undefined&site_id=3&first=0&limit=20&sort=points&league_id=4&lang=en&division=-1&key=50c2cd9b5e18e390&client_code=ahl&league_id=4&callback=json" # rubocop:disable Layout/LineLength
    end

    def goalies_url
      "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=players&season=#{@season_id}&team=#{@team_id}&position=goalies&rookies=0&statsType=standard&rosterstatus=undefined&site_id=3&first=0&limit=20&sort=gaa&league_id=4&lang=en&division=-1&qualified=all&key=50c2cd9b5e18e390&client_code=ahl&league_id=4&callback=json" # rubocop:disable Layout/LineLength
    end
  end
end
