require "multidispatch/store"
require "multidispatch/interceptor"
require "multidispatch/version"

module Multidispatch

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    @@interceptor = Interceptor.new(Store.new)

    def method_added(method_name)
      @@interceptor.intercept(instance_method(method_name))
    end
  end

end
