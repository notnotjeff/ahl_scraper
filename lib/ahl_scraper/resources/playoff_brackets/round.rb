# frozen_string_literal: true

module AhlScraper
  module PlayoffBrackets
    class Round < Resource
      def id
        @id ||= @raw_data[:round].to_i
      end

      def name
        @name ||= @raw_data[:round_name]
      end

      def season_id
        @season_id ||= @raw_data[:season_id].to_i
      end

      def round_type_id
        @round_type_id ||= @raw_data[:round_type_id].to_i
      end

      def round_type_name
        @round_type_name ||= @raw_data[:round_type_name]
      end

      def active?
        @active = series.filter(&:active?).any? if @active.nil?
        @active
      end

      def series
        @series ||= @raw_data[:matchups].map { |series| Series.new(series, { bracket_data: @opts[:bracket_data] }) }
      end
    end
  end
end
