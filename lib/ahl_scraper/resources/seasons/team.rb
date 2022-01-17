# frozen_string_literal: true

module AhlScraper
  module Seasons
    class Team < Resource
      attr_reader :division

      EXCEPTIONS = {
        "albany-river-rats" => { city: "Albany", name: "River Rats" },
        "bridgeport-sound-tigers" => { city: "Bridgeport", name: "Sound Tigers" },
        "grand-rapids-griffins" => { city: "Grand Rapids", name: "Griffins", abbreviation: "GR" },
        "hartford-wolf-pack" => { city: "Hartford", name: "Wolf Pack" },
        "lake-erie-monsters" => { city: "Lake Erie", name: "Monsters" },
        "lowell-lock-monsters" => { city: "Lowell", name: "Lock Monsters" },
        "lehigh-valley-phantoms" => { city: "Lehigh Valley", name: "Phantoms" },
        "manitoba-moose" => { city: "Manitoba", name: "Moose", abbreviation: "MB" },
        "oklahoma-city-barons" => { city: "Oklahoma City", name: "Barons" },
        "omaha-ak-sar-ben-knights" => { city: "Omaha", name: "Ak-Sar-Ben Knights" },
        "quad-city-flames" => { city: "Quad City", name: "Flames" },
        "san-antonio-rampage" => { city: "San Antonio", name: "Rampage" },
        "san-diego-gulls" => { city: "San Diego", name: "Gulls" },
        "san-jose-barracuda" => { city: "San Jose", name: "Barracuda" },
        "st-john-s-icecaps" => { city: "St. John's", name: "IceCaps" },
        "st-john-s-maple-leafs" => { city: "St. John's", name: "Maple Leafs" },
        "cincinnati-mighty-ducks" => { city: "Cincinnati", name: "Mighty Ducks" },
        "wilkes-barre-scranton-penguins" => { city: "Wilkes-Barre/Scranton", name: "Penguins", game_file_city: "W-B/Scranton" },
        "edmonton-road-runners" => { city: "Edmonton", name: "Road Runners" },
        "henderson-silver-knights" => { city: "Henderson", name: "Silver Knights" },
      }.freeze

      def initialize(raw_data, division, opts = {})
        super(raw_data, opts)
        @division = division
      end

      def id
        @id ||= @raw_data.dig(:prop, :team_code, :teamLink)&.to_i
      end

      def full_name
        @full_name ||= @raw_data.dig(:row, :name)&.delete_prefix("y -")&.delete_prefix("x -")&.delete_prefix("xy -")&.strip
      end

      def abbreviation
        @abbreviation ||= EXCEPTIONS[parameterized_name]&.dig(:abbreviation) || @raw_data.dig(:row,
          :team_code)&.delete_prefix("y -")&.delete_prefix("x -")&.delete_prefix("xy -")&.strip
      end

      def parameterized_name
        @parameterized_name ||= ParameterizeHelper.new(full_name).call
      end

      def city
        @city ||= full_name&.split.length > 2 ? exception_split_object&.dig(:city) : full_name&.split[0]
      end

      def name
        @name ||= full_name&.split.length > 2 ? exception_split_object&.dig(:name) : full_name&.split[1]
      end

      def game_file_city
        @game_file_city ||= EXCEPTIONS[parameterized_name]&.dig(:game_file_city)
      end

      private

      def exception_split_object
        @exception_split_object ||=
          if !EXCEPTIONS[parameterized_name]
            puts "Three word team name #{full_name} not recognized, must manually decipher team name and city"
            {}
          else
            EXCEPTIONS[parameterized_name]
          end
      end
    end
  end
end
