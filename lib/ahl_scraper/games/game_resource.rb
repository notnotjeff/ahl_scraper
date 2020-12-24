# frozen_string_literal: true

module AhlScraper
  module Games
    class GameResource
      include Enumerable

      def initialize(raw_data, opts = {})
        @raw_data = raw_data
        @opts = opts
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
    end
  end
end
