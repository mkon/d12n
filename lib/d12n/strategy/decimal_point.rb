require 'bigdecimal'

module D12n
  module Strategy
    module DecimalPoint
      extend self

      # must raise ArgumentError when format is invalid
      def number_to_bigdecimal(formatted)
        BigDecimal.new formatted.tr(',', '')
      end
    end
  end
end
