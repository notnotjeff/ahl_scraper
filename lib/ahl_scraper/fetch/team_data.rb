# frozen_string_literal: true

module AhlScraper
  module Fetch
    class TeamData
      def initialize(season_id)
        @season_id = season_id
      end

      def call
        JSON.parse(Nokogiri::HTML(URI.parse(url).open).text[5..-2], symbolize_names: true)&.first&.dig(:sections)&.map { |t| t[:data] }&.flatten
      end

      private

      def url
        @url ||= "https://lscluster.hockeytech.com/feed/index.php?feed=statviewfeed&view=teams&groupTeamsBy=division&site_id=1&season=#{@season_id}&key=50c2cd9b5e18e390&client_code=ahl&league_id=4&callback=json" # rubocop:disable Layout/LineLength
      end
    end
  end
end
