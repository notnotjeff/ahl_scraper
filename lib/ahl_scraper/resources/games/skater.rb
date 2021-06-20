# frozen_string_literal: true

module AhlScraper
  module Games
    class Skater < Resource
      def id
        @id ||= @raw_data[:id]
      end

      def first_name
        @first_name ||= @raw_data[:first_name]
      end

      def last_name
        @last_name ||= @raw_data[:last_name]
      end

      def position
        @position ||= @raw_data[:position]
      end

      def jersey_number
        @jersey_number ||= @raw_data[:number]
      end

      def birthdate
        @birthdate ||= valid_birthdate? ? @raw_data[:birthdate] : nil
      end

      def current_age
        @current_age ||= valid_birthdate? ? BirthdateHelper.new(birthdate).age_on_date(@opts[:game_date]) : nil
      end

      def team_id
        @team_id ||= @raw_data[:team_id]
      end

      def team_abbreviation
        @team_abbreviation ||= @raw_data[:team_abbreviation]
      end

      def starting
        @starting ||= @raw_data[:starting]
      end

      def captaincy
        @captaincy ||= @raw_data[:captaincy]
      end

      def home_team
        @home_team ||= @raw_data[:home_team]
      end

      def stats
        @stats ||= {
          faceoff_attempts: @raw_data[:faceoff_attempts],
          faceoff_wins: @raw_data[:faceoff_wins],
          hits: @raw_data[:hits],
          penalty_minutes: @raw_data[:penalty_minutes],
        }
      end

      def shots
        @shots ||= { sog_as: @raw_data[:sog_as] }
      end

      def scoring
        @scoring ||= @opts[:scoring_statline]
      end

      def on_ice
        @on_ice ||= @opts[:on_ice_statline]
      end

      def penalty
        @penalty ||= @opts[:penalty_statline]
      end

      def penalty_shot
        @penalty_shot ||= @opts[:penalty_shot_statline] || {}
      end

      def shootout
        @shootout ||= @opts[:shootout_statline] || {}
      end

      private

      def valid_birthdate?
        @valid_birthdate ||= !@raw_data[:birthdate].empty? && @raw_data[:birthdate] != "0000-00-00"
      end
    end
  end
end
