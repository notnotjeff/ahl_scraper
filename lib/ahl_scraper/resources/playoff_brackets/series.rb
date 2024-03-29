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
        "76" => { "1" => 2, "2" => 3, "3" => 4, "4" => 4, "5" => 4 },
        "80" => { "1" => 2, "2" => 3, "3" => 3, "4" => 4, "5" => 4 },
        "default" => { "1" => 2, "2" => 3, "3" => 3, "4" => 4, "5" => 4 },
      }.freeze

      def id
        @id ||= @raw_data[:series_letter]
      end

      def name
        @name ||= @raw_data[:series_name]
      end

      def season_id
        @season_id ||= find_season_id
      end

      def logo_url
        @logo_url ||= @raw_data[:series_logo]
      end

      def round
        @round ||= @raw_data[:round].to_i
      end

      def started?
        @started = @raw_data[:active] == "1" if @started.nil?
        @started
      end

      def active?
        @active ||= team_ids_present? && team1_wins < wins_needed && team2_wins < wins_needed if @active.nil?
        @active
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
        @home_team_id = first_game&.dig(:home_team)&.to_i if @home_team_id.nil?
        @home_team_id
      end

      def away_team_id
        @away_team_id = first_game&.dig(:visiting_team)&.to_i if @away_team_id.nil?
        @away_team_id
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
        @wins_needed ||= find_wins_needed
      end

      def finished?
        @finished = winning_team_id.present? if @finished.nil?
        @finished
      end

      private

      def find_wins_needed
        return OVERRIDE_WINS_NEEDED.dig(season_id.to_s, round.to_s) unless OVERRIDE_WINS_NEEDED.dig(season_id.to_s, round.to_s).nil?

        return (round == 1 ? 3 : 4) if season_id.to_i < OVERRIDE_WINS_NEEDED.keys.map(&:to_i).max

        OVERRIDE_WINS_NEEDED.dig("default", round.to_s)
      end

      def find_season_id
        dig_season_id = @opts.dig(:bracket_data, :rounds, round - 1, :season_id)

        return if dig_season_id.nil? || dig_season_id.empty?

        dig_season_id.to_i
      end

      def first_game
        @first_game ||= @raw_data.dig(:games, 0)
      end

      def find_winner
        return team1 if team1_wins == wins_needed

        return team2 if team2_wins == wins_needed

        nil
      end

      def team1
        @team1 ||= @raw_data[:team1].to_i.zero? ? nil : @raw_data[:team1].to_i
      end

      def team2
        @team2 ||= @raw_data[:team2].to_i.zero? ? nil : @raw_data[:team2].to_i
      end

      def team_ids_present?
        !team1.nil? && !team2.nil?
      end

      def team1_wins
        @team1_wins ||= @raw_data[:team1_wins].to_i
      end

      def team2_wins
        @team2_wins ||= @raw_data[:team2_wins].to_i
      end
    end
  end
end
