require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe MarketLoader do
      it "should load market data and stocks with prices" do
        MarketLoader.load_from_directory(
          RAILS_ROOT + '/spec/fixtures/csv/dowjones', :skip_lines => 1)
        
        market = Market.find_by_name 'dowjones'
        
        market.data.size.should eql(2)
        market.data.should do |data|
          data[0].date.should eql('10/5/2008')
          data[0].volume.should eql('1000')
          data[0].open.should eql('10434.81')
          data[0].close.should eql('10317.36')
          data[0].high.should eql('10438.47')
          data[0].close.should eql('10316.16')
          data[1].date.should eql('10/6/2008')
          data[1].volume.should eql('2000')
          data[1].open.should eql('10317.16')
          data[1].close.should eql('10287.1')
          data[1].high.should eql('10369.55')
          data[1].close.should eql('10218.09')
        end
        
        market.stocks.size.should eql(1)
        stock = market.stocks[0]
        stock.name.should eql('ibm')
        stock.description.should eql('IBM - International Business Machine')
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
    end
  end
end