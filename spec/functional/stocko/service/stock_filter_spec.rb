require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

describe Stocko::Service::StockFilter do
  before :each do
    class TestService
      include Stocko::Service::StockFilter
    end
    @service = TestService.new
    
    market = Market.create!(:name => 'market')
    stock = Stock.create!(:market => market, :name => 'xxx')
  end
  
  it "should set stock" do
    @service.stock "xxx"
    @service.stock.name.should eql("xxx")
  end
end