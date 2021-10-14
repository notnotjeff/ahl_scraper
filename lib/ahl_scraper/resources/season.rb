# frozen_string_literal: true

module AhlScraper
  class Season < Resource
    attr_reader :id, :name, :season_type

    def initialize(raw_data)
      @id = raw_data[:id].to_i
      @name = raw_data[:name]
      @season_type = set_season_type
      @division_data = %i[regular playoffs].include?(season_type) ? DivisionDataFetcher.new(@id).call : []
    end

    def abbreviation
      @abbreviation ||=
        case season_type
        when :regular
          "#{start_year.to_s[-2..-1]}-#{end_year.to_s[-2..-1]}"
        when :playoffs
          "#{start_year.to_s[-2..-1]}PO"
        when :all_star_game
          "#{start_year.to_s[-2..-1]}ASG"
        when :exhibition
          "#{start_year.to_s[-2..-1]}-#{end_year.to_s[-2..-1]}EX"
        when :preseason
          "#{start_year.to_s[-2..-1]}PS"
        end
    end

    def start_year
      @start_year ||=
        case season_type
        when :regular, :exhibition
          name[/(.*?)\-/].to_i
        when :playoffs, :all_star_game, :preseason
          name[/(.*?) /].to_i
        end
    end

    def start_date
      @start_date ||= set_start_date
    end

    def end_date
      @end_date ||= set_end_date
    end

    def end_year
      @end_year ||=
        case season_type
        when :regular, :exhibition
          start_year + 1
        when :playoffs, :all_star_game, :preseason
          start_year
        end
    end

    def divisions
      @divisions ||= @division_data.map { |d| d.dig(:headers, :name, :properties, :title) }
    end

    def teams
      @teams ||= %i[regular playoffs].include?(season_type) ? Seasons::TeamsService.new(@division_data).call : []
    end

    private

    def set_season_type
      case name
      when /Exhibition/
        :exhibition
      when /All-Star/
        :all_star_game
      when /Playoffs/
        :playoffs
      when /Regular/
        :regular
      when /Preseason/
        :preseason
      end
    end

    def set_start_date
      return unless %i[playoffs regular].include? season_type

      day = SeasonStartDateFetcher.new(@id, season_type).call
      "#{day} #{start_year}"
    end

    def set_end_date
      return unless %i[playoffs regular].include? season_type

      day = SeasonEndDateFetcher.new(@id, season_type).call
      "#{day} #{end_year}"
    end
  end
end
