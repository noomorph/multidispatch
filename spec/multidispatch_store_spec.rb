describe Multidispatch::Store do

  context "when released" do
    it "can be locked" do
      expect { subject.lock! }.to change { subject.locked? }.from(nil).to(true)
    end

    it "has no effect to release" do
      expect { subject.release! }.not_to change { subject.locked? }
    end

    context "when method added" do
      before { @the_method = subject.set(Hash, :is_a?) }

      it { @the_method.should be_instance_of(UnboundMethod) }
      its(:store) { should == {"Hash" => {:is_a? => {1 => @the_method}}} }

      it "get() returns it" do
        subject.get(Hash, :is_a?, 1).should == @the_method
      end

      it "does not allow to add same method twice" do
        expect { subject.set(Hash, :is_a?) }.to raise_error
      end
    end
    
  end

  context "when locked" do
    before { subject.lock! }

    it "can be released" do
      expect { subject.release! }.to change { subject.locked? }.from(true).to(nil)
    end
    
    context "when try to add method" do
      before { @the_method = subject.set(Object, :some_method) }

      it { @the_method.should be_nil }
      its(:store) { should == {} }
    end
  end

end
