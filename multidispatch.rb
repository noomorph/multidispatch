module Multidispatch
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def define(name, &block)
      unless self.instance_variable_defined?(:@multi)
        self.instance_variable_set(:@multi, {})
        define_method(name) do |*args|
          multi = self.class.instance_variable_get(:@multi)
          multi[name][args.count].call(*args)
        end
      end

      multi = self.instance_variable_get(:@multi)
      multi[name] ||= {}
      multi[name][block.arity] = block;
    end
  end
end