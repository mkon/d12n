module D12n
  module ModelSupport
    module ClassMethods
      def d12n_attribute(*args)
        options = args.extract_options!
        prefix = options[:prefix] || 'local'
        args.each do |name|
          define_reader name, prefix
          define_writer name, prefix
        end
      end

      private

      def define_reader(name, prefix)
        define_method "#{prefix}_#{name}" do
          local = instance_variable_get "@#{prefix}_#{name}"
          return local if local
          ActiveSupport::NumberHelper::NumberToDelimitedConverter.convert(send(name), {})
        end
      end

      def define_writer(name, prefix)
        define_method "#{prefix}_#{name}=" do |val|
          begin
            instance_variable_set "@#{prefix}_#{name}", val
            send "#{name}=", D12n.strategy.number_to_bigdecimal(val)
            val
          rescue ArgumentError
            val
          end
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end
  end
end
