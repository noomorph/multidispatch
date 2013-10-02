describe Multidispatch::Store do

  context "when released" do
    it "can be locked" do
      expect { subject.lock! }.to change { subject.locked? }.from(nil).to(true)
    end

    it "has no effect to release" do
      expect { subject.release! }.not_to change { subject.locked? }
    end

    context "when method added" do
      before { @the_method = subject.set(Hash, :inspect) }

      it { @the_method.should be_instance_of(UnboundMethod) }
      its(:store) { should == {"Hash" => {:inspect => {0 => @the_method}}} }

      it "get() returns it" do
        subject.get(Hash, :inspect, 0).should == @the_method
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
