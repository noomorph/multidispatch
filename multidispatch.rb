module Multidispatch
  def self.included(base)
    base.instance_variable_set :@_def_lock, nil
    base.instance_variable_set :@_def_dispatch, {}
    base.extend(ClassMethods)
  end

  module ClassMethods
    def method_added(name)
      return if @_def_lock # prevent recursion

      method = instance_method(name)

      dispatch = @_def_dispatch
      dispatch[name] ||= {}
      dispatch[name][method.arity] = method;

      @_def_lock = true
      define_method(name) do |*args|
        dispatch = self.class.instance_variable_get(:@_def_dispatch)
        method = dispatch[name][args.count]
        method.bind(self).call(*args)
      end
      @_def_lock = nil
    end
  end
end
