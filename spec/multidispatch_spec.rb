require "spec_helper"

describe Multidispatch do

end

describe Multidispatch::Store do
  context "when not locked" do
    it "can be locked" do
      expect { subject.lock! }.to change { subject.locked? }.from(nil).to(true)
    end

    it "should return method on adding" do
      subject.set(Hash, :inspect).should be_instance_of(UnboundMethod)
    end
    
    it "should return method on getting after adding" do
      subject.set(Hash, :inspect)
      subject.get(Hash, :inspect, 0).should be_instance_of(UnboundMethod)
    end
  end

  context "when locked" do
    before { subject.lock! }

    it "can be released" do
      expect { subject.release! }.to change { subject.locked? }.from(true).to(nil)
    end
    
    it "should return nil after adding method" do
      subject.set(Object, :some_method).should be_nil
    end

    it "should stay empty after adding method" do
      subject.set(Object, :some_method)
      subject.to_s().should == {}.to_s
    end
  end

end
