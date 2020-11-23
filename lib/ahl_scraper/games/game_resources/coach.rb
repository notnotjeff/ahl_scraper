# frozen_string_literal: true

module AhlScraper
  module Games
    class Coach < GameResource
      attr_reader :first_name, :last_name, :role, :team_id

      def initialize(raw_data, opts = {})
        @first_name = raw_data[:firstName]
        @last_name = raw_data[:lastName]
        @role = raw_data[:role]
        @team_id = opts[:team_id]
      end
    end
  end
end
