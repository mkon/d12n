module I18n
  module Backend
    class SimpleMock < Simple
      def initialize(config)
        @config = config
      end

      def translate(_locale, key, _options = {})
        case key
        when :"number.format"
          @config
        when :"number.format.delimiter"
          @config[:delimiter]
        when :"number.format.seperator"
          @config[:seperator]
        end
      end
    end
  end
end
