# frozen_string_literal: true

module AhlScraper
  class GameTag < Tag
    def initialize(raw_data)
      @raw_data = raw_data
    end

    def id
      @id ||= @raw_data[:row][:game_id].to_i
    end

    def home_team_city
      @home_team_city ||= @raw_data[:row][:home_team_city]
    end

    def home_team_score
      @home_team_score ||= @raw_data[:row][:home_goal_count].to_i
    end

    def home_team_id
      @home_team_id ||= @raw_data[:prop][:home_team_city][:teamLink].to_i
    end

    def away_team_city
      @away_team_city ||= @raw_data[:row][:visiting_team_city]
    end

    def away_team_score
      @away_team_score ||= @raw_data[:row][:visiting_goal_count].to_i
    end

    def away_team_id
      @away_team_id ||= @raw_data[:prop][:visiting_team_city][:teamLink].to_i
    end

    def date
      @date ||= @raw_data[:row][:date_with_day]
    end

    def status
      @status ||= @raw_data[:row][:game_status]
    end

    def game_report_url
      @game_report_url ||= @raw_data[:prop][:game_report][:link]
    end

    def game_sheet_url
      @game_sheet_url ||= @raw_data[:prop][:game_sheet][:link]
    end

    def game_center_url
      @game_center_url ||= "https://theahl.com/stats/game-center/#{id}"
    end
  end
end
