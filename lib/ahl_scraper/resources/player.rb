# frozen_string_literal: true

module AhlScraper
  class Player < Resource
    def initialize(raw_data, opts = {})
      super(raw_data, opts)
    end

    def id
      @id ||= @raw_data.dig(:info, :playerId).to_i
    end

    def name
      @name ||= "#{first_name} #{last_name}"
    end

    def first_name
      @first_name ||= @raw_data.dig(:info, :firstName)
    end

    def last_name
      @last_name ||= @raw_data.dig(:info, :lastName)
    end

    def handedness
      @handedness ||= position == "G" ? @raw_data.dig(:info, :catches) : @raw_data.dig(:info, :shoots)
    end

    def birthplace
      @birthplace ||= @raw_data.dig(:info, :birthPlace)&.strip
    end

    def height
      @height ||= @raw_data.dig(:info, :height_hyphenated)
    end

    def birthdate
      @birthdate ||= valid_birthdate? ? @raw_data.dig(:info, :birthDate) : nil
    end

    def draft_year
      @draft_year ||= valid_birthdate? ? BirthdateHelper.new(birthdate).draft_year : nil
    end

    def current_age
      @current_age ||= valid_birthdate? ? BirthdateHelper.new(birthdate).current_age : nil
    end

    def jersey_number
      @jersey_number ||= @raw_data.dig(:info, :jerseyNumber).to_i
    end

    def position
      @position ||= @raw_data.dig(:info, :position)
    end

    def weight
      @weight ||= @raw_data.dig(:info, :weight).to_i
    end

    def draft_info
      @draft_info ||= Players::DraftInfo.new(draft_data)
    end

    private

    def valid_birthdate?
      @valid_birthdate ||= !@raw_data.dig(:info, :birthDate).empty? && @raw_data.dig(:info, :birthDate) != "0000-00-00"
    end

    def draft_data
      nhl_draft = @raw_data.dig(:info, :drafts)&.select { |draft| draft[:draft_league] == "NHL" }&.dig(0)

      return {} if nhl_draft.nil?

      nhl_draft
    end
  end
end
