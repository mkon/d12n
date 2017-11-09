module D12n
  module ModelSupport
    module ClassMethods
      def d12n_attribute(*args)
        args.each do |name|
          attr_reader "local_#{name}"
          define_method "local_#{name}=" do |val|
            instance_variable_set "@local_#{name}", val
            send "#{name}=", D12n.strategy.number_to_bigdecimal(val)
          end
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end
