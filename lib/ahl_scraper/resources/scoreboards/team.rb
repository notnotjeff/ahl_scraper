# frozen_string_literal: true

module AhlScraper
  module Scoreboards
    class Team < Resource
      def id
        @id ||= @raw_data[:id].to_i
      end

      def abbreviation
        @abbreviation ||= @raw_data[:abbreviation]
      end

      def city
        @city ||= @raw_data[:city]
      end

      def name
        @name ||= @raw_data[:name]
      end

      def full_name
        @full_name ||= @raw_data[:full_name]
      end

      def division
        @division ||= @raw_data[:division]
      end

      def score
        @score ||= @raw_data[:score].to_i
      end

      def audio_url
        @audio_url ||= @raw_data[:audio_url]
      end

      def video_url
        @video_url ||= @raw_data[:video_url]
      end

      def webcasts_url
        @webcasts_url ||= @raw_data[:webcasts_url]
      end

      def wins
        @wins ||= @raw_data[:wins].to_i
      end

      def regulation_losses
        @regulation_losses ||= @raw_data[:regulation_losses].to_i
      end

      def ot_losses
        @ot_losses ||= @raw_data[:ot_losses].to_i
      end

      def shootout_losses
        @shootout_losses ||= @raw_data[:shootout_losses].to_i
      end

      def logo
        @logo ||= @raw_data[:logo]
      end
    end
  end
end
