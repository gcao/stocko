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
        stock.prices.should do |price|
          price[0].date.should eql('10/5/2005')
          price[0].volume.should eql('4999200')
          price[0].open.should eql('79.7209')
          price[0].close.should eql('78.6142')
          price[0].high.should eql('79.1577')
          price[0].close.should eql('78.8711')
          price[1].date.should eql('10/6/2005')
          price[1].volume.should eql('8130200')
          price[1].open.should eql('79.3157')
          price[1].close.should eql('77.7644')
          price[1].high.should eql('78.8711')
          price[1].close.should eql('78.7525')
        end
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

