# frozen_string_literal: true

module AhlScraper
  class GoalieGameListItem < Resource
    def initialize(raw_data)
      @raw_data = raw_data
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

    def goals_against
      @goals_against ||= @raw_data[:row][:goals_against].to_i
    end

    def shots_against
      @shots_against ||= @raw_data[:row][:shots_against].to_i
    end

    def saves
      @saves ||= @raw_data[:row][:saves].to_i
    end

    def goals_against_average
      @goals_against_average ||= @raw_data[:row][:gaa].to_f
    end

    def save_percent
      @save_percent ||= @raw_data[:row][:svpct].to_f
    end

    def minutes
      @minutes ||= @raw_data[:row][:minutes]
    end

    def result
      @result ||= set_result
    end

    def shutout?
      @shutout ||= @raw_data[:row][:shutout] == "1"
    end

    private

    def set_result
      return "won" if @raw_data[:row][:win] == "1"

      # return "so_loss" if @raw_data[:row][:so_loss] == "1"

      return "ot_loss" if @raw_data[:row][:ot_loss] == "1"

      return "loss" if @raw_data[:row][:loss] == "1"

      return "played_but_no_result" if @raw_data[:row][:minutes] != "0:00"

      "did_not_play"
    end
  end
end
