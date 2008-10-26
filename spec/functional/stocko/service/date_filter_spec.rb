require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

describe Stocko::Service::DateFilter do
  before :each do
    class TestService
      include Stocko::Service::DateFilter
    end
    @service = TestService.new
  end

  it "should set from date" do
    @service.from_date "11/1/2005"

    @service.from_date.should eql(Date.parse('11/1/2005'))
  end

  it "should set to date" do
    @service.to_date "11/30/2005"

    @service.to_date.should eql(Date.parse('11/30/2005'))
  end

  it "should set date range" do
    @service.date "11/1/2005", "11/30/2005"

    @service.from_date.should eql(Date.parse('11/1/2005'))
    @service.to_date.should eql(Date.parse('11/30/2005'))
  end
end