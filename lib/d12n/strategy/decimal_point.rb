require 'bigdecimal'

module D12n
  module Strategy
    module DecimalPoint
      extend self

      # must raise ArgumentError when format is invalid
      def formatted_to_bigdecimal(formatted)
        BigDecimal.new formatted.tr(',', '')
      end

      def bigdecimal_to_formatted(internal)
        ActiveSupport::NumberHelper::NumberToDelimitedConverter.convert(internal, {})
      end
    end
  end
end
