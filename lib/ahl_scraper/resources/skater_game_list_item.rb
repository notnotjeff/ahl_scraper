# frozen_string_literal: true

module AhlScraper
  class SkaterGameListItem < Resource
    def initialize(raw_data, opts = {})
      super(raw_data, opts)
    end

    def game_id
      @game_id ||= @raw_data[:prop][:game][:gameLink].to_i
    end

    def game_name
      @game_name ||= @raw_data[:row][:game]
    end

    def date
      @date ||= @raw_data[:row][:date_played]
    end

    def shots
      @shots ||= @raw_data[:row][:shots].to_i
    end

    def goals
      @goals ||= @raw_data[:row][:goals].to_i
    end

    def goals_pp
      @goals_pp ||= @raw_data[:row][:pp].to_i
    end

    def goals_sh
      @goals_sh ||= @raw_data[:row][:sh].to_i
    end

    def points
      @points ||= @raw_data[:row][:points].to_i
    end

    def game_winning_goals
      @game_winning_goals ||= @raw_data[:row][:gw].to_i
    end

    def plus_minus
      @plus_minus ||= @raw_data[:row][:plusminus].to_i
    end

    def assists
      @assists ||= @raw_data[:row][:assists].to_i
    end

    def shootout_goals
      @shootout_goals ||= @raw_data[:row][:shootout_goals].to_i
    end

    def shootout_attempts
      @shootout_attempts ||= @raw_data[:row][:shootout_attempts].to_i
    end

    def penalty_minutes
      @penalty_minutes ||= @raw_data[:row][:penalty_minutes].to_i
    end
  end
end
