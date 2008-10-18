require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe Change do
  before :each do
    klass = Class.new do
      include Change
      def open; BigDecimal.new('100'); end
      def close; BigDecimal.new('150'); end
      def high; BigDecimal.new('200'); end
      def low; BigDecimal.new('50'); end
      def change; BigDecimal.new('0.5'); end
      def max_change; BigDecimal.new('1.5'); end
    end
    
    @obj = klass.new
  end
  
  it "up?" do
    @obj.up?.should be_true
  end
  
  it "down?" do
    @obj.down?.should be_false
  end
end