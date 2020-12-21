# frozen_string_literal: true

module AhlScraper
  module Games
    class Coach < GameResource
      def first_name
        @first_name ||= @raw_data[:firstName]
      end

      def last_name
        @last_name ||= @raw_data[:lastName]
      end

      def role
        @role ||= @raw_data[:role]
      end

      def team_id
        @team_id ||= @opts[:team_id]
      end
    end
  end
end
