# frozen_string_literal: true

module AhlScraper
  module Games
    class Info < GameResource
      def id
        @id ||= @raw_data[:id]
      end

      def name
        @name ||= @opts[:name]
      end

      def date
        @date ||= @raw_data[:date]
      end

      def game_number
        @game_number ||= @raw_data[:gameNumber]
      end

      def venue
        @venue ||= @raw_data[:venue]
      end

      def attendance
        @attendance ||= @raw_data[:attendance]
      end

      def start_time
        @start_time ||= @raw_data[:startTime]
      end

      def end_time
        @end_time ||= @raw_data[:endTime]
      end

      def duration
        @duration ||= @raw_data[:duration]
      end

      def game_report_url
        @game_report_url ||= @raw_data[:gameReportUrl]
      end

      def text_boxscore_url
        @text_boxscore_url ||= @raw_data[:textBoxscoreUrl]
      end

      def tickets_url
        @tickets_url ||= @raw_data[:ticketsUrl]
      end

      def started
        @started ||= @raw_data[:started]
      end

      def final
        @final ||= @raw_data[:final]
      end

      def public_notes
        @public_notes ||= @raw_data[:publicNotes]
      end

      def status
        @status ||= @raw_data[:status]
      end

      def season_id
        @season_id ||= @raw_data[:seasonId]
      end

      def htv_game_id
        @htv_game_id ||= @raw_data[:htvGameId]
      end

      def datetime
        @datetime ||= @raw_data[:GameDateISO8601]
      end
    end
  end
end
