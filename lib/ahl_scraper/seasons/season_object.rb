# frozen_string_literal: true

module AhlScraper
  module Seasons
    class SeasonObject
      attr_reader :id, :name, :start_date, :end_date

      def initialize(raw_data)
        @raw_data = raw_data
        @id = @raw_data[:id].to_i
        @name = @raw_data[:name]
        @season_type = season_type
        @division_data = %i[regular playoffs].include?(season_type) ? [] : [] # Fetch::DivisionData.fetch(id)
        @start_date, @end_date = Format::SeasonDates.new(@id, @season_type, @name).call
      end

      def values
        @values ||= (self.class.instance_methods(false) - %i[to_json inspect each keys [] values]).map do |m|
          [m, send(m)]
        end.to_h.transform_keys(&:to_sym)
      end

      def inspect
        "#<#{self.class.to_s.split('::').last}:0x#{object_id.to_s(16)} #{values}>"
      end

      def [](key)
        values[key.to_sym]
      end

      def keys
        values.keys
      end

      def to_json(*_opts)
        JSON.generate(values)
      end

      def each(&blk)
        values.each(&blk)
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
          end
      end

      def season_type
        @season_type ||=
          case name
          when /Exhibition/
            :exhibition
          when /All-Star/
            :all_star_game
          when /Playoffs/
            :playoffs
          when /Regular/
            :regular
          end
      end

      def start_year
        @start_year ||=
          case season_type
          when :regular, :exhibition
            name[/(.*?)\-/].to_i
          when :playoffs, :all_star_game
            name[/(.*?) /].to_i
          end
      end

      def end_year
        @end_year ||=
          case season_type
          when :regular, :exhibition
            start_year + 1
          when :playoffs, :all_star_game
            start_year
          end
      end

      def divisions
        @divisions ||= @division_data.map { |d| d.dig(:headers, :name, :properties, :title) }
      end

      def teams
        @teams ||= %i[regular playoffs].include?(season_type) ? Format::Teams.new(@division_data).call : []
      end
    end
  end
end
