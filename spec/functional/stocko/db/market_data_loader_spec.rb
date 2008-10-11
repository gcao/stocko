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