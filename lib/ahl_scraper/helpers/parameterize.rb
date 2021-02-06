# frozen_string_literal: true

module AhlScraper
  module Helpers
    class Parameterize
      attr_reader :string, :separator, :preserve_case

      def initialize(string, separator: "-", preserve_case: false)
        @string = string
        @separator = separator
        @preserve_case = preserve_case
      end

      def call
        parameterized_string = string.dup.to_s

        parameterized_string.gsub!(/[^a-zA-Z0-9\-_]+/, separator)

        unless separator.nil? || separator.empty?
          if separator == "-"
            re_duplicate_separator        = /-{2,}/
            re_leading_trailing_separator = /^-|-$/
          else
            re_sep = Regexp.escape(separator)
            re_duplicate_separator = /#{re_sep}{2,}/
            re_leading_trailing_separator = /^#{re_sep}|#{re_sep}$/
          end
          parameterized_string.gsub!(re_duplicate_separator, separator)
          parameterized_string.gsub!(re_leading_trailing_separator, "")
        end

        parameterized_string.downcase! unless preserve_case
        parameterized_string
      end
    end
  end
end
