require 'active_support'
require 'active_support/core_ext/hash'
require 'bigdecimal'

module D12n
  include ActiveSupport::Configurable

  module Strategy
    autoload :DecimalPoint, 'd12n/strategy/decimal_point'
    autoload :DecimalComma, 'd12n/strategy/decimal_comma'
    autoload :Default,      'd12n/strategy/default'
  end

  autoload :ModelSupport, 'd12n/model_support'

  def self.strategy
    config.strategy || Strategy::Default
  end
end
