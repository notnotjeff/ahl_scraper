# frozen_string_literal: true

module AhlScraper
  module Seasons
    class TeamObject
      include AhlScraper::Helpers::Parameterize
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
      }.freeze

      def initialize(raw_data, division)
        @raw_data = raw_data
        @division = division
      end

      def values
        @values ||= (self.class.instance_methods(false) - %i[to_json inspect each keys [] values]).map do |m|
          [m, send(m)]
        end.to_h.transform_keys(&:to_sym)
      end

      def inspect
        "#<#{self.class.to_s.split('::').last}:0x#{object_id.to_s(16)} #{values}>"
      end

      def [](key)
        values[key.to_sym]
      end

      def keys
        values.keys
      end

      def to_json(*_opts)
        JSON.generate(values)
      end

      def each(&blk)
        values.each(&blk)
      end

      def id
        @id ||= @raw_data.dig(:prop, :team_code, :teamLink)&.to_i
      end

      def full_name
        @full_name ||= @raw_data.dig(:row, :name)&.delete_prefix("y -")&.delete_prefix("x -")&.delete_prefix("xy -")&.strip
      end

      def abbreviation
        @abbreviation ||= EXCEPTIONS[parameterized_name]&.dig(:abbreviation) || @raw_data.dig(:row, :team_code)&.delete_prefix("y -")&.delete_prefix("x -")&.delete_prefix("xy -")&.strip
      end

      def parameterized_name
        @parameterized_name ||= parameterize(full_name)
      end

      def city
        @city ||= full_name.split.length > 2 ? EXCEPTIONS[parameterized_name][:city] : full_name.split[0]
      end

      def name
        @name ||= full_name.split.length > 2 ? EXCEPTIONS[parameterized_name][:name] : full_name.split[1]
      end

      def game_file_city
        @game_file_city ||= EXCEPTIONS[parameterized_name]&.dig(:game_file_city)
      end
    end
  end
end
