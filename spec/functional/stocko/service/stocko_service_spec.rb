require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Service
    describe StockoService do
      before :each do
        @service = StockoService.new

        market = Market.create!(:name => 'market')
        @stock = Stock.create!(:market => market, :name => 'xxx')
      end

      it "should returns default market" do
        @service.market.should eql(Market.first)
      end

      it "should include StockFilter module" do
        StockoService.included_modules.should include(StockFilter)
      end

      it "should include DateFilter module" do
        StockoService.included_modules.should include(DateFilter)
      end

      it "should include ChangeFilter module" do
        StockoService.included_modules.should include(ChangeFilter)
      end
      
      describe "prices" do
        it "return StockPrice by default" do
          @service.prices.should eql(StockPrice)
        end
        
        it "filter by stock" do
          @service.stock @stock.name
          
          mock(o = StockPrice).stock(@stock)
          @service.prices
        end
        
        it "filter by date" do
          @service.from_date '11/1/2008'
          
          mock(o = StockPrice).after(Date.parse('11/1/2008'))
          @service.prices
        end
        
        it "filter by change" do
          @service.change_gt 0.01
          
          mock(o = StockPrice).change_gt(BigDecimal.new('0.01'))
          @service.prices
        end
      end
    end
  end
end