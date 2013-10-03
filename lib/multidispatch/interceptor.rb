class Multidispatch::Interceptor
  attr_accessor :store

  def initialize(store = nil)
    @store = store
  end

  def intercept(method)
    return if @store.locked? # prevent recursion

    store = @store
    store.set(method.owner, method.name)
    store.lock!

    method_body = lambda do |*args|
      method = store.get(self.class, method.name, args.count)
      method.bind(self).call(*args)
    end

    method.owner.class_eval { define_method method.name, method_body }
    store.release!
  end
end
