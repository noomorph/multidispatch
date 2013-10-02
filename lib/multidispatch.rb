require "multidispatch/store"
require "multidispatch/version"

module Multidispatch

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    @@store = Store.new

    def method_added(name)
      return if @@store.locked? # prevent recursion
      @@store.set(self, name)

      @@store.lock!
      define_method(name) do |*args|
        method = @@store.get(self.class, name, args.count)
        method.bind(self).call(*args)
      end
      @@store.release!
    end
  end
end
