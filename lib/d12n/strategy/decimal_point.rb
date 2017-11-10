require 'bigdecimal'

module D12n
  module Strategy
    module DecimalPoint
      include Default
      extend self

      private

      def format_delimiter
        ','
      end

      def format_seperator
        '.'
      end
    end
  end
end
