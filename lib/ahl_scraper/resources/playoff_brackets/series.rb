# frozen_string_literal: true

module AhlScraper
  module PlayoffBrackets
    class Series < Resource
      OVERRIDE_WINS_NEEDED = {
        "36" => { "1" => 4 },
        "39" => { "1" => 4 },
        "33" => { "1" => 4 },
        "29" => { "1" => 4 },
        "15" => { "1" => 4 },
        "10" => { "1" => 4 },
        "7" => { "1" => 4 },
        "69" => { "1" => 4 },
        "72" => { "1" => 1, "2" => 1, "3" => 2, "4" => 2 },
      }.freeze

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
        @active ||= @raw_data[:active] == "1" && team1_wins < wins_needed && team2_wins < wins_needed
      end

      def home_feeder_series
        @home_feeder_series ||= home_team_id == team1 ? @raw_data[:feeder_series1] : @raw_data[:feeder_series2]
      end

      def away_feeder_series
        @away_feeder_series ||= home_team_id == team1 ? @raw_data[:feeder_series2] : @raw_data[:feeder_series1]
      end

      def winning_team_id
        @winning_team_id ||= @raw_data[:winner].empty? ? find_winner : @raw_data[:winner].to_i
      end

      def home_team_id
        @home_team_id ||= first_game[:home_team].to_i
      end

      def away_team_id
        @away_team_id ||= first_game[:visiting_team].to_i
      end

      def home_team_wins
        @home_team_wins ||= home_team_id == team1 ? team1_wins : team2_wins
      end

      def away_team_wins
        @away_team_wins ||= home_team_id == team1 ? team2_wins : team1_wins
      end

      def ties
        @ties ||= @raw_data[:ties].to_i
      end

      def games
        @games ||= @raw_data[:games].map { |game| Game.new(game) }
      end

      def wins_needed
        @wins_needed ||= OVERRIDE_WINS_NEEDED.dig(season_id, round.to_s) || (round == 1 ? 3 : 4)
      end

      private

      def first_game
        @first_game ||= @raw_data[:games][0]
      end

      def find_winner
        return team1 if team1_wins == wins_needed

        return team2 if team2_wins == wins_needed

        nil
      end

      def season_id
        @opts[:bracket_data]&.dig(:rounds, round - 1, :season_id)
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
    end
  end
end
