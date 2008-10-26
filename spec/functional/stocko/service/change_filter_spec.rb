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

  describe "filter" do
    it "filter_by_change from" do
      @service.change_gt 0.01

      mock(source = Object.new).change_gt(BigDecimal.new('0.01'))
      @service.filter_by_change(source)
    end

    it "filter_by_change to" do
      @service.change_lt -0.01

      mock(source = Object.new).change_lt(BigDecimal.new('-0.01'))
      @service.filter_by_change(source)
    end

    it "filter_by_change from, to" do
      @service.change_gt -0.01
      @service.change_lt 0.01

      mock(source = Object.new).change_between(BigDecimal.new("-0.01"), BigDecimal.new("0.01"))
      @service.filter_by_change(source)
    end

    it "filter_by_change returns source if both from and to are not set" do
      source = Object.new
      @service.filter_by_change(source).should eql(source)
    end
  end
end