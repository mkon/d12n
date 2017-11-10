module D12n
  module Strategy
    module DecimalComma
      include Default
      extend self

      private

      def format_delimiter
        '.'
      end

      def format_separator
        ','
      end
    end
  end
end
