require File.expand_path(File.dirname(__FILE__) + '/integration_spec_helper')

describe StockoService do
  before :each do
    @service = StockoService.new
  end
  
  it "should set active stock" do
    @service.instance_eval do
      stock "ibm"
    end
    
    @service.stock.should eql(Stock.ibm)
  end
  
  it "should set from date" do
    @service.instance_eval do
      from_date "11/1/2005"
    end
    
    @service.from_date.should eql(Date.parse('11/1/2005'))
  end
  
  it "should set to date" do
    @service.instance_eval do
      to_date "11/30/2005"
    end
    
    @service.to_date.should eql(Date.parse('11/30/2005'))
  end
  
  it "should set date range" do
    @service.instance_eval do
      date "11/1/2005", "11/30/2005"
    end
    
    @service.from_date.should eql(Date.parse('11/1/2005'))
    @service.to_date.should eql(Date.parse('11/30/2005'))
  end
  
  it "should return prices" do
    @service.instance_eval do
      stock "ibm"
      date "11/1/2005", "11/30/2005"
      prices
    end
    
    @service.last_value.size.should eql(21)
  end
end
