# frozen_string_literal: true

module AhlScraper
  module Seasons
    class TeamsService
      def initialize(division_data)
        @division_data = division_data
      end

      def call
        @division_data.map do |division|
          division_name = division.dig(:headers, :name, :properties, :title)
          Array.new(division[:data]).map do |team|
            Team.new(team, division_name)
          end
        end.flatten
      end
    end
  end
end
