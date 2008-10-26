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
  
  it "filter_by_date from_date" do
    @service.from_date "11/1/2005"
    
    mock(source = Object.new).after(Date.parse('11/1/2005'))
    @service.filter_by_date(source)
  end
  
  it "filter_by_date to_date" do
    @service.to_date "11/1/2005"
    
    mock(source = Object.new).before(Date.parse('11/1/2005'))
    @service.filter_by_date(source)
  end
  
  it "filter_by_date from_date, to_date" do
    @service.from_date "11/1/2005"
    @service.to_date "11/30/2005"
    
    mock(source = Object.new).between(Date.parse('11/1/2005'), Date.parse('11/30/2005'))
    @service.filter_by_date(source)
  end
  
  it "filter_by_date returns source if from_date and to_date are both nil" do
    source = Object.new
    @service.filter_by_date(source).should eql(source)
  end
end