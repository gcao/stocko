require File.expand_path(File.dirname(__FILE__) + '/../../integration_spec_helper')

describe Stocko::Service::StockoService do
  before :each do
    @service = Stocko::Service::StockoService.new
  end

  it "should return prices" do
    @service.stock "ibm"
    @service.date "11/1/2005", "11/30/2005"
    @service.prices.size.should eql(21)
  end
end
