require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe MarketDataLoader do
      it "should load market csv into market table" do
        market = Market.create!(:name => 'dowjones')
        
        MarketDataLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/csv/market_data.csv', market, :skip_lines => 1)

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
      end
      
      it "should skip duplicate line (has same date as previous line)" do
        market = Market.create!(:name => 'dowjones')
        
        MarketDataLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/csv/market_data_dup_lines.csv', market, :skip_lines => 1)
        
        market = Market.find_by_name 'dowjones'
        market.data.size.should eql(1)
      end
    end
  end
end