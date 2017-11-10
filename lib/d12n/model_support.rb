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
          read_d12n_attribute name, options
        end
      end

      def define_writer(name, options)
        define_method "#{options[:prefix]}_#{name}=" do |val|
          write_d12n_attribute name, val, options
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    private

    def read_d12n_attribute(name, options = {})
      localized = instance_variable_get "@#{options[:prefix]}_#{name}"
      return localized if localized
      number = send(name)
      return unless number
      # If a factor is defined, internal presentation is an integer multiple of the local value
      number /= options[:factor].to_f if options[:factor]
      D12n.strategy.bigdecimal_to_formatted(number)
    end

    def write_d12n_attribute(name, val, options = {})
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
