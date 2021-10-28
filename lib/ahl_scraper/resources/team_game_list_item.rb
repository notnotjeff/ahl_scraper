# frozen_string_literal: true

module AhlScraper
  class TeamGameListItem < Resource
    def initialize(raw_data, opts = {})
      super(raw_data, opts)
    end

    def game_id
      @game_id ||= @raw_data[:row][:game_id].to_i
    end

    def game_name
      @game_name ||= "#{away_team[:city]} @ #{home_team[:city]}"
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
      @game_center_url ||= "https://theahl.com/stats/game-center/#{game_id}"
    end

    def home_score
      @home_score ||= @raw_data[:row][:home_goal_count].to_i
    end

    def away_score
      @away_score ||= @raw_data[:row][:visiting_goal_count].to_i
    end

    def home_team
      @home_team ||= {
        id: @raw_data[:prop][:home_team_city][:teamLink].to_i,
        city: @raw_data[:row][:home_team_city],
      }
    end

    def away_team
      @away_team ||= {
        id: @raw_data[:prop][:visiting_team_city][:teamLink].to_i,
        city: @raw_data[:row][:visiting_team_city],
      }
    end

    def at_home?
      @at_home ||= @opts[:team_id] == home_team[:id]
    end
  end
end
