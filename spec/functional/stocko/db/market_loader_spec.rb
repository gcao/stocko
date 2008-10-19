require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe MarketLoader do
      it "should load market data and stocks with prices" do
        MarketLoader.load_from_directory(
          RAILS_ROOT + '/spec/fixtures/functional/dowjones', :skip_lines => 1)
        
        market = Market.find_by_name 'dowjones'
        
        market.data.size.should eql(2)
        market.data[0].date.strftime.should eql('2005-10-05')
        market.data[0].volume.should eql(1000)
        market.data[0].open.should eql(BigDecimal.new('10434.81'))
        market.data[0].close.should eql(BigDecimal.new('10317.36'))
        market.data[0].high.should eql(BigDecimal.new('10438.47'))
        market.data[0].low.should eql(BigDecimal.new('10316.16'))
        market.data[1].date.strftime.should eql('2005-10-06')
        market.data[1].volume.should eql(2000)
        market.data[1].open.should eql(BigDecimal.new('10317.36'))
        market.data[1].close.should eql(BigDecimal.new('10287.1'))
        market.data[1].high.should eql(BigDecimal.new('10369.55'))
        market.data[1].low.should eql(BigDecimal.new('10218.09'))
        
        market.stocks.size.should eql(1)
        stock = market.stocks[0]
        stock.name.should eql('ibm')
        stock.description.should eql('IBM - International Business Machine')
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
    end
  end
end