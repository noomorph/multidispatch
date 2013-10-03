require "spec_helper"

describe Multidispatch do
  it "should have self.included method" do
    subject.method(:included).should_not be_nil
  end
end

describe Multidispatch::ClassMethods do
  it "defines variable `interceptor`" do
    subject.class_variable_defined?(:@@interceptor).should be_true
  end

  it "`interceptor` is Multidispatch::Interceptor" do
    i = subject.send :class_variable_get, :@@interceptor
    i.should be_instance_of(Multidispatch::Interceptor)
  end
end
