describe "integration test" do

  it "should not overwrite methods of previous classes" do
    class Intersect1
      include Multidispatch
      def foo() "foo"; end
    end

    class Intersect2
      include Multidispatch
      def foo() "bar"; end
    end

    Intersect1.new.foo.should == "foo"
  end

  it "should work" do
    class Foo
      include Multidispatch

      def foo() "foo"; end
      def foo(a) "foo #{a}"; end
      def foo(n, a) "#{n} foo #{a}"; end
    end

    f = Foo.new
    f.foo().should == "foo"
    f.foo(5).should == "foo 5"
    f.foo(0,1).should == "0 foo 1"
  end
end
