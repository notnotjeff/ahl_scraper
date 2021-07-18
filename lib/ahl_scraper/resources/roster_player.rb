# frozen_string_literal: true

module AhlScraper
  class RosterPlayer < Resource
    attr_reader :team_id, :season_id

    def initialize(raw_data, team_id, season_id)
      @raw_data = raw_data
      @team_id = team_id
      @season_id = season_id
    end

    def id
      @id ||= @raw_data.dig(:bio, :row, :player_id).to_i
    end

    def name
      @name ||= @raw_data.dig(:bio, :row, :name)
    end

    def handedness
      @handedness ||= position == "G" ? @raw_data.dig(:bio, :row, :catches) : @raw_data.dig(:bio, :row, :shoots)
    end

    def birthplace
      @birthplace ||= @raw_data.dig(:bio, :row, :birthplace)
    end

    def height
      @height ||= @raw_data.dig(:bio, :row, :height_hyphenated)
    end

    def birthdate
      @birthdate ||= @raw_data.dig(:bio, :row, :birthdate)
    end

    def draft_year
      @draft_year ||= valid_birthdate? ? birthdate_object.draft_year : nil
    end

    def current_age
      @current_age ||= valid_birthdate? ? birthdate_object.current_age : nil
    end

    def jersey_number
      @jersey_number ||= @raw_data.dig(:bio, :row, :tp_jersey_number).to_i
    end

    def position
      @position ||= @raw_data.dig(:bio, :row, :position)
    end

    def weight
      @weight ||= @raw_data.dig(:bio, :row, :w).to_i
    end

    def rookie?
      @rookie ||= @raw_data.dig(:stats, :prop, :rookie, :rookie) == "1"
    end

    private

    def birthdate_object
      @birthdate_object ||= BirthdateHelper.new(birthdate)
    end

    def valid_birthdate?
      @valid_birthdate ||= !@raw_data.dig(:bio, :row, :birthdate).empty? && @raw_data.dig(:bio, :row, :birthdate) != "0000-00-00"
    end
  end
end
