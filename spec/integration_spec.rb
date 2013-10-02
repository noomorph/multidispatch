require "spec_helper"

describe "integration test" do

  context "when 2 classes have method with same name" do
    class Intersect1
      include Multidispatch
      def foo() 1; end
    end

    class Intersect2
      include Multidispatch
      def foo() 2; end
    end

    it "does not overwrite previously defined method" do
      Intersect1.new.foo.should == 1
    end

    it "allows to define next method with same name" do
      Intersect2.new.foo.should == 2
    end
  end

  class Bar
    include Multidispatch

    def foo() "foo"; end
    def foo(a) "foo #{a}"; end
    def foo(n, a) "#{n} foo #{a}"; end
  end

  describe Bar do
    it { subject.foo.should == "foo" }
    it { subject.foo(5).should == "foo 5" }
    it { subject.foo(0,1).should == "0 foo 1" }
  end

end
