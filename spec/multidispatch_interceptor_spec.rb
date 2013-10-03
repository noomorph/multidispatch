describe Multidispatch::Interceptor do
  context "when store is locked" do
    before { subject.store = double(:locked? => true, :set => nil) }

    it "should not save method to store" do
      subject.intercept(nil)
      expect(subject.store).to_not have_received(:set)
    end
  end

  context "when store has no lock" do
    class Foo; def foo; end end

    before do
      subject.store = double({
        :locked? => false,
        :lock! => nil,
        :set => nil,
        :release! => nil
      })
      @foo = Foo.instance_method(:foo)
    end

    it "should save method to store" do
      subject.intercept(@foo)
      expect(subject.store).to have_received(:set).with(Foo, :foo)
    end

    it "should lock store before re-defining method" do
      subject.intercept(@foo)
      expect(subject.store).to have_received(:lock!)
    end

    it "should re-define owner class method" do
      klass = double(:class_eval => nil)
      subject.intercept(double(:owner => klass, :name => "method"))

      expect(klass).to have_received(:class_eval)
    end

    it "should release store after re-defining method" do
      subject.intercept(@foo)
      expect(subject.store).to have_received(:release!)
    end

  end
end
