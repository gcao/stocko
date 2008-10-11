require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe StockLoader do
      before :each do
        market = Market.create!(:name => 'dowjones')
        
        StockLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/csv/dowjones/ibm.csv', market, :skip_lines => 1)
        @stock = Stock.find_by_name 'ibm'
      end
      
      it "should load stock with prices" do
        @stock.prices.size.should eql(2)
        @stock.prices.should do |price|
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
      
      it "should load stock description from <STOCK_NAME>.txt" do
        @stock.description.should eql('IBM - International Business Machine')
      end
    end
  end
end