# frozen_string_literal: true

module AhlScraper
  module PlayoffBrackets
    class Series < Resource
      def id
        @id ||= @raw_data[:series_letter]
      end

      def name
        @name ||= @raw_data[:series_name]
      end

      def logo_url
        @logo_url ||= @raw_data[:series_logo]
      end

      def round
        @round ||= @raw_data[:round].to_i
      end

      def active?
        @active ||= @raw_data[:active] == "1"
      end

      def feeder_series1
        @feeder_series1 ||= @raw_data[:feeder_series1]
      end

      def feeder_series2
        @feeder_series2 ||= @raw_data[:feeder_series2]
      end

      def team1
        @team1 ||= @raw_data[:team1].to_i
      end

      def team2
        @team2 ||= @raw_data[:team2].to_i
      end

      def team1_wins
        @team1_wins ||= @raw_data[:team1_wins]
      end

      def team2_wins
        @team2_wins ||= @raw_data[:team2_wins]
      end

      def winning_team
        @winning_team ||= @raw_data[:winner].empty? ? nil : @raw_data[:winner].to_i
      end

      def ties
        @ties ||= @raw_data[:ties]
      end

      def home_team_id
        @home_team_id ||= first_game[:home_team].to_i
      end

      def games
        @games ||= @raw_data[:games].map { |game| Game.new(game) }
      end

      private

      def first_game
        @first_game ||= @raw_data[:games][0]
      end
    end
  end
end
