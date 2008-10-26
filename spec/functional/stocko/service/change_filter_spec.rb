require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

describe Stocko::Service::ChangeFilter do
  before :each do
    class TestService
      include Stocko::Service::ChangeFilter
    end
    @service = TestService.new
  end
  
  it "should set change_gt (change >=)" do
    @service.change_gt 0.01

    @service.change_gt.should eql(BigDecimal.new('0.01'))
  end
  
  it "should set change_lt (change <=)" do
    @service.change_lt -0.01
    
    @service.change_lt.should eql(BigDecimal.new('-0.01'))
  end
  
  it "should set change range (from <= change <= to)" do
    @service.change -0.01, 0.01
    
    @service.change_gt.should eql(BigDecimal.new('-0.01'))
    @service.change_lt.should eql(BigDecimal.new('0.01'))
  end
end