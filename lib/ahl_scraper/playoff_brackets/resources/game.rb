# frozen_string_literal: true

module AhlScraper
  module PlayoffBrackets
    class Game < Resource
      def id
        @id ||= @raw_data[:game_id].to_i
      end

      def home_team
        @home_team ||= @raw_data[:home_team].to_i
      end

      def home_score
        @home_score ||= @raw_data[:home_goal_count].to_i
      end

      def away_team
        @away_team ||= @raw_data[:visiting_team].to_i
      end

      def away_score
        @away_score ||= @raw_data[:visiting_goal_count].to_i
      end

      def status
        @status ||= @raw_data[:game_status]
      end

      def date
        @date ||= @raw_data[:date_time]
      end

      def if_necessary?
        @if_necessary ||= @raw_data[:if_necessary] == "1"
      end

      def notes
        @notes ||= @raw_data[:game_notes]
      end
    end
  end
end
