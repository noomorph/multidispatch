require "spec_helper"

describe Multidispatch do
  it "should have self.included method" do
    subject.method(:included).should_not be_nil
  end
end
