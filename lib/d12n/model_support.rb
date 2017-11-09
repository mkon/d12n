module D12n
  module ModelSupport
    module ClassMethods
      def d12n_attribute(*args)
        options = args.extract_options!
        prefix = options[:prefix] || 'local'
        args.each do |name|
          attr_reader "#{prefix}_#{name}"
          define_method "#{prefix}_#{name}=" do |val|
            instance_variable_set "@#{prefix}_#{name}", val
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
