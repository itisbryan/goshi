class ParamsValidator
  include Errors::Exceptions

  attr_reader :constraints, :validations

  def initialize(&block)
    @constraints = {}
    @validations = {}
    instance_exec(&block)
  end

  def build(params)
    params.permit! if params.is_a? ActionController::Parameters

    @validations.each do |msg, validation|
      raise self.class::InvalidParams, msg unless validation.call(params)
    end

    if params.is_a? Array
      params.map do |child|
        case child
        when Hash, ActionController::Parameters
          prebuild(child)
        else
          raise self.class::InvalidParams, "Elements should be hash"
        end
      end
    else
      prebuild(params)
    end
  end

  private

  def validate(message, &block)
    validations[message] = block
  end

  def optional(key, options = {}, &args)
    construct_field(true, key, options, &args)
  end

  def mandatory(key, options = {}, &args)
    construct_field(false, key, options, &args)
  end

  def prebuild(params)
    validated_params = {}
    @constraints.each do |key, constraint|
      value = params[key]
      value = value.to_h if value.is_a? ActionController::Parameters
      raise self.class::MissingParams, "#{key} is missing" if !params.key?(key) && !constraint[:optional]

      next unless params.key?(key)

      value = constraint[:transform].call(value) if constraint[:transform]

      if constraint[:type]&.none? { |k| value.is_a? k }
        raise self.class::InvalidParams, "#{key} should be a #{constraint[:type]}, given #{value.class.name}"
      end

      value = constraint[:children].build(value) if constraint[:children]

      raise self.class::InvalidParams, "#{key} should be in #{constraint[:in]}" if constraint[:in]&.exclude?(value)

      raise self.class::InvalidParams, "#{key} is invalid" if constraint[:validate] && !constraint[:validate].call(value)

      validated_params[key] = value
    end

    validated_params
  end

  def construct_field(optional, key, options = {}, &args)
    @constraints[key] = { optional: optional }

    if options[:type]
      if options[:type].is_a? Array
        raise ArgumentError, 'type should be an array of classes' unless options[:type].all?(Class)

        @constraints[key][:type] = options[:type]
      else
        raise ArgumentError, 'type should be a class' unless options[:type].is_a? Class

        @constraints[key][:type] = [options[:type]]
      end
    end

    @constraints[key][:transform] = options[:transform] if options[:transform].respond_to?(:call)
    @constraints[key][:validate] = options[:validate] if options[:validate].respond_to?(:call)
    @constraints[key][:in] = options[:in] if options[:in].is_a?(Range) || options[:in].is_a?(Array)

    @constraints[key][:children] = self.class.new(&args) if args
  end
end
