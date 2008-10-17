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
        market.data[0].date.should eql(Date.parse('2005-10-05'))
        market.data[0].volume.should eql(1000)
        market.data[0].open.should eql(BigDecimal.new('10434.81'))
        market.data[0].close.should eql(BigDecimal.new('10317.36'))
        market.data[0].high.should eql(BigDecimal.new('10438.47'))
        market.data[0].low.should eql(BigDecimal.new('10316.16'))
        market.data[1].date.should eql(Date.parse('2005-10-06'))
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
      
      it "should populate market dates table" do
        market = Market.create!(:name => 'dowjones')
        
        MarketDataLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/csv/market_data.csv', market, :skip_lines => 1)
          
        dates = MarketDate.all
        dates.size.should eql(2)
        dates[0].date.should eql(Date.parse('2005-10-5'))
        dates[0].next.date.should eql(Date.parse('2005-10-6'))
        dates[0].year.should eql(2005)
        dates[0].month.should eql(10)
        dates[0].first_of_month.should be_true
        dates[0].last_of_month.should be_false
        dates[1].date.should eql(Date.parse('2005-10-6'))
        dates[1].prev.date.should eql(Date.parse('2005-10-5'))
        dates[1].year.should eql(2005)
        dates[1].month.should eql(10)
        dates[1].first_of_month.should be_false
        dates[1].last_of_month.should be_true
      end
    end
  end
end