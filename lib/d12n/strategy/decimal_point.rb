require 'bigdecimal'

module D12n
  module Strategy
    module DecimalPoint
      extend self

      def number_to_bigdecimal(formatted)
        BigDecimal.new formatted.tr(',', '')
      end
    end
  end
end
