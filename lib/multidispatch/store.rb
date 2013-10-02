module Multidispatch

  class Store
    attr_reader :store

    def initialize
      @store = {}
      @locked = nil
    end

    def get(klass, method_name, params_count)
      class_methods = @store[klass.name] || {}
      methods = class_methods[method_name] || {}
      method_body = methods[params_count]
      raise NoMethodError unless method_body
      method_body
    end

    def set(klass, method_name)
      return nil if locked?

      class_methods = @store[klass.name] ||= {}
      methods = class_methods[method_name] ||= {}
      method = klass.instance_method(method_name)
      params_count = method.parameters.count

      unless methods.has_key? params_count
        methods[params_count] = method
      else
        prev_method = methods[params_count]
        raise collision_error_message(klass, prev_method, method)
      end
    end

    def locked?
      @locked
    end

    def lock!
      @locked = true
      self
    end

    def release!
      @locked = nil
      self
    end

    private

    def signature_for(method)
      params = method.parameters.map { |p| p.join ' ' }.join ', '
      return "def #{method.name}(#{params})"
    end

    def collision_error_message(klass, prev_method, new_method)
      prev_signature = signature_for prev_method
      new_signature  = signature_for new_method

      msg = "Multidispatch error in class #{klass}:\n"
      msg += "#{prev_signature} is already defined\n"
      msg += "and cannot be overwriten with\n"
      msg += "#{new_signature} is already defined"
    end
  end

end
