module D12n
  module ModelSupport
    module ClassMethods
      def d12n_attribute(*args)
        options = args.extract_options!
        options.reverse_merge! prefix: 'local'
        args.each do |name|
          define_reader name, options
          define_writer name, options
        end
      end

      private

      def define_reader(name, options)
        define_method "#{options[:prefix]}_#{name}" do
          local = instance_variable_get "@#{options[:prefix]}_#{name}"
          return local if local
          number = send(name)
          # If a factor is defined, internal presentation is an integer multiple of the local value
          number /= options[:factor].to_f if options[:factor]
          D12n.strategy.bigdecimal_to_formatted(number)
        end
      end

      def define_writer(name, options)
        define_method "#{options[:prefix]}_#{name}=" do |val|
          begin
            instance_variable_set "@#{options[:prefix]}_#{name}", val
            number = D12n.strategy.formatted_to_bigdecimal(val)
            # If a factor is defined, internal presentation is an integer multiple of the local value
            number = (number * options[:factor].to_f).to_i if options[:factor]
            send "#{name}=", number
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
