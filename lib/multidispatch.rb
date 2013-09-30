require "version"

module Multidispatch

  class Store
    def initialize
      @store = {}
      @locked = nil
    end

    def get(klass, method_name, arity)
      class_methods = @store[klass.name] || {}
      methods = class_methods[method_name] || {}
      method_body = methods[-1] || methods[arity]
      raise NoMethodError unless method_body
      method_body
    end

    def set(klass, method_name)
      return nil if locked?

      class_methods = @store[klass.name] ||= {}
      methods = class_methods[method_name] ||= {}
      method = klass.instance_method(method_name)
      methods[method.arity] = method
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

    def to_s
      @store.to_s
    end
  end

  @store = Store.new

  def self.included(base)
    base.instance_variable_set :@_def_lock, nil
    base.instance_variable_set :@_def_dispatch, {}
    base.extend(ClassMethods)
  end

  module ClassMethods
    def method_added(name)
      return if @store.locked? # prevent recursion

      @store.set(self, method_name)

      @store.lock!
      define_method(name) do |*args|
        method = @@store.get(self.class, name, args.count)
        method.bind(self).call(*args)
      end
      @store.release!
    end
  end
end
