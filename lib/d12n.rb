require 'active_support'
require 'bigdecimal'

module D12n
  include ActiveSupport::Configurable

  module Strategy
    autoload :DecimalPoint, 'd12n/strategy/decimal_point'
    autoload :DecimalComma, 'd12n/strategy/decimal_comma'
  end

  autoload :ModelSupport, 'd12n/model_support'

  def self.strategy
    config.strategy || Strategy::DecimalPoint
  end
end
