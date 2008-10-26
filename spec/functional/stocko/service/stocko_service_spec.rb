require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Service
    describe StockoService do
      before :each do
        @service = StockoService.new

        market = Market.create!(:name => 'market')
        stock = Stock.create!(:market => market, :name => 'xxx')
      end

      it "should set active stock" do
        @service.stock "xxx"

        @service.stock.should eql(Stock.xxx)
      end

      it "should include DateFilter module" do
        StockoService.included_modules.should include(DateFilter)
      end

      it "should include ChangeFilter module" do
        StockoService.included_modules.should include(ChangeFilter)
      end
    end
  end
end