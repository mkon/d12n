require 'bigdecimal'

module D12n
  module Strategy
    module DecimalComma
      extend self

      def number_to_bigdecimal(formatted)
        BigDecimal.new formatted.tr('.', '').tr(',', '.')
      end
    end
  end
end
