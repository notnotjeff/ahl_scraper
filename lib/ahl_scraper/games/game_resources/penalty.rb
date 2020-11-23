# frozen_string_literal: true

module AhlScraper
  module Games
    class Penalty < GameResource
      def number
        @number ||= @opts[:number]
      end

      def period
        @period ||= @raw_data.dig(:period, :id)
      end

      def time
        @time ||= @raw_data[:time]
      end

      def infracting_player_id
        @infracting_player_id ||= @raw_data.dig(:takenBy, :id)
      end

      def infracting_player_first_name
        @infracting_player_first_name ||= @raw_data.dig(:takenBy, :firstName)
      end

      def infracting_player_last_name
        @infracting_player_last_name ||= @raw_data.dig(:takenBy, :lastName)
      end

      def infracting_player_jersey_number
        @infracting_player_jersey_number ||= @raw_data.dig(:takenBy, :jerseyNumber)
      end

      def infracting_player_position
        @infracting_player_position ||= @raw_data.dig(:takenBy, :position)
      end

      def infracting_player_birthdate
        @infracting_player_birthdate ||= @raw_data.dig(:takenBy, :birthdate)
      end

      def serving_player_id
        @serving_player_id ||= @raw_data.dig(:servedBy, :id)
      end

      def serving_player_first_name
        @serving_player_first_name ||= @raw_data.dig(:servedBy, :firstName)
      end

      def serving_player_last_name
        @serving_player_last_name ||= @raw_data.dig(:servedBy, :lastName)
      end

      def serving_player_jersey_number
        @serving_player_jersey_number ||= @raw_data.dig(:servedBy, :jerseyNumber)
      end

      def serving_player_position
        @serving_player_position ||= @raw_data.dig(:servedBy, :position)
      end

      def serving_player_birthdate
        @serving_player_birthdate ||= @raw_data.dig(:servedBy, :birthdate)
      end

      def opposing_team_id
        @opposing_team_id ||= @raw_data.dig(:againstTeam, :id)
      end

      def opposing_team_name
        @opposing_team_name ||= @raw_data.dig(:againstTeam, :name)
      end

      def opposing_team_city
        @opposing_team_city ||= @raw_data.dig(:againstTeam, :city)
      end

      def opposing_team_nickname
        @opposing_team_nickname ||= @raw_data.dig(:againstTeam, :nickname)
      end

      def opposing_team_abbreviation
        @opposing_team_abbreviation ||= @raw_data.dig(:againstTeam, :abbreviation)
      end

      def opposing_team_logo_url
        @opposing_team_logo_url ||= @raw_data.dig(:againstTeam, :logo)
      end

      def minutes
        @minutes ||= @raw_data[:minutes]
      end

      def description
        @description ||= @raw_data[:description]
      end

      def rule_number
        @rule_number ||= @raw_data[:rule_number]
      end

      def power_play?
        @power_play ||= @raw_data[:isPowerPlay]
      end
    end
  end
end
