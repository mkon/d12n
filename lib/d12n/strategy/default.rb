module D12n
  module Strategy
    module Default
      extend self

      # must raise ArgumentError when format is invalid
      def formatted_to_bigdecimal(formatted)
        BigDecimal.new formatted.tr(format_delimiter, '').tr(format_seperator, '.')
      end

      def bigdecimal_to_formatted(internal)
        ActiveSupport::NumberHelper::NumberToDelimitedConverter.convert(internal, {})
      end

      private

      # seperates the thousands, eg 1,000
      def format_delimiter
        ::I18n.translate(:'number.format.delimiter')
      end

      # seperates the decimal points, eg 9.95
      def format_seperator
        ::I18n.translate(:'number.format.seperator')
      end
    end
  end
end
