# frozen_string_literal: true

module AhlScraper
  module Players
    class DraftInfo < Resource
      def id
        @id ||= @raw_data[:id]&.to_i
      end

      def league
        @draft_league ||= @raw_data[:draft_league]
      end

      def team_name
        @team_name ||= @raw_data[:draft_team]
      end

      def team_id
        @team_id ||= @raw_data[:draft_team_id]&.to_i
      end

      def year
        @year ||= @raw_data[:draft_year]&.to_i
      end

      def round
        @round ||= @raw_data[:draft_round]&.to_i
      end

      def rank
        @rank ||= @raw_data[:draft_rank]&.to_i
      end

      def junior_team
        @junior_team ||= @raw_data[:draft_junior_team]
      end

      def team_logo
        @team_logo ||= @raw_data[:draft_logo]
      end

      def description
        @description ||= @raw_data[:draft_text]&.strip
      end
    end
  end
end
