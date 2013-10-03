require "spec_helper"

describe Multidispatch do
  it "should have self.included method" do
    subject.method(:included).should_not be_nil
  end

  it "should extend in self.included method" do
    class IsExtended; end
    subject.included(IsExtended)

    modules = IsExtended.singleton_class.included_modules
    modules.should include(Multidispatch::ClassMethods)
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
  
  it "should not extend class that does not include it" do
    class DoesNotInclude
    end

    DoesNotInclude.method(:method_added).should_not == subject
  end

  it "should extend class that includes it" do
    class Includes
      extend Multidispatch::ClassMethods
    end

    Includes.method(:method_added).owner.should == subject
  end
end
