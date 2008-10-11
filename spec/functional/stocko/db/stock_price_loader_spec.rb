require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe StockPriceLoader do
      it "should load stock price csv into stock prices table" do
        market = Market.create!(:name => 'dowjones')
        Stock.create!(:market => market, :name => 'ibm') # ibm matches the name in csv
        
        StockPriceLoader.load_from_file(
        RAILS_ROOT + '/spec/fixtures/csv/stock_prices.csv', :skip_lines => 1)

        stock = Stock.find_by_name 'ibm'
        stock.prices.size.should eql(2)
        stock.prices[0].date.strftime.should eql('2005-10-05')
        stock.prices[0].volume.should eql(4999200)
        stock.prices[0].open.should eql(BigDecimal.new('79.1577'))
        stock.prices[0].close.should eql(BigDecimal.new('78.8711'))
        stock.prices[0].high.should eql(BigDecimal.new('79.7209'))
        stock.prices[0].low.should eql(BigDecimal.new('78.6142'))
        stock.prices[1].date.strftime.should eql('2005-10-06')
        stock.prices[1].volume.should eql(8130200)
        stock.prices[1].open.should eql(BigDecimal.new('78.8711'))
        stock.prices[1].close.should eql(BigDecimal.new('78.7525'))
        stock.prices[1].high.should eql(BigDecimal.new('79.3157'))
        stock.prices[1].low.should eql(BigDecimal.new('77.7644'))
      end
      
      it "should skip duplicate lines(has same date as previous line)" do
        market = Market.create!(:name => 'dowjones')
        Stock.create!(:market => market, :name => 'ibm') # ibm matches the name in csv
        
        StockPriceLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/csv/stock_prices_dup_lines.csv', :skip_lines => 1)
        
        stock = Stock.find_by_name 'ibm'
        stock.prices.size.should eql(1)
      end
    end
  end
end
