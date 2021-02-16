# frozen_string_literal: true

module AhlScraper
  module Games
    class ShootoutAttempt < GameResource
      def number
        @number ||= @opts[:number]
      end

      def goal?
        @goal ||= @raw_data[:isGoal]
      end

      def game_winner?
        @game_winner ||= @raw_data[:isGameWinningGoal]
      end

      def shooter
        @shooter ||= {
          id: @raw_data[:shooter][:id],
          first_name: @raw_data[:shooter][:firstName],
          last_name: @raw_data[:shooter][:lastName],
          jersey_number: @raw_data[:shooter][:jerseyNumber],
          position: @raw_data[:shooter][:position],
        }
      end

      def goalie
        @goalie ||= {
          id: @raw_data[:goalie][:id],
          first_name: @raw_data[:goalie][:firstName],
          last_name: @raw_data[:goalie][:lastName],
          jersey_number: @raw_data[:goalie][:jerseyNumber],
          position: @raw_data[:goalie][:position],
        }
      end

      def shooting_team
        @shooting_team ||= {
          id: @raw_data[:shooterTeam][:id],
          full_name: @raw_data[:shooterTeam][:name],
          city: @raw_data[:shooterTeam][:city],
          name: @raw_data[:shooterTeam][:nickname],
          abbreviation: @raw_data[:shooterTeam][:abbreviation],
          logo_url: @raw_data[:shooterTeam][:logo],
        }
      end

      def goalie_team
        @goalie_team ||= {
          id: @opts[:opposing_team].id,
          full_name: @opts[:opposing_team].name,
          city: @opts[:opposing_team].city,
          name: @opts[:opposing_team].name,
          abbreviation: @opts[:opposing_team].abbreviation,
          logo_url: @opts[:opposing_team].logo_url,
        }
      end
    end
  end
end
