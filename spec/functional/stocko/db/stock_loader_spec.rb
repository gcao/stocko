require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe StockLoader do
      before :each do
        @stock = Stock.find_by_name 'ibm'
        StockLoader.load_from_file(@stock,
          RAILS_ROOT + '/spec/fixtures/functional/dowjones/ibm.csv', :skip_lines => 1)
      end
      
      it "should load stock with prices" do
        @stock.prices.size.should eql(2)
        @stock.prices[0].date.strftime.should eql('2005-10-05')
        @stock.prices[0].volume.should eql(4999200)
        @stock.prices[0].open.should eql(BigDecimal.new('79.1577'))
        @stock.prices[0].close.should eql(BigDecimal.new('78.8711'))
        @stock.prices[0].high.should eql(BigDecimal.new('79.7209'))
        @stock.prices[0].low.should eql(BigDecimal.new('78.6142'))
        @stock.prices[1].date.strftime.should eql('2005-10-06')
        @stock.prices[1].volume.should eql(8130200)
        @stock.prices[1].open.should eql(BigDecimal.new('78.8711'))
        @stock.prices[1].close.should eql(BigDecimal.new('78.7525'))
        @stock.prices[1].high.should eql(BigDecimal.new('79.3157'))
        @stock.prices[1].low.should eql(BigDecimal.new('77.7644'))
      end
      
      it "should load stock description from <STOCK_NAME>.txt" do
        @stock.description.should eql('IBM - International Business Machine')
      end
    end
  end
end