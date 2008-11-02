require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe IndexPriceLoader do
      it "should load index prices csv into index prices table" do
        index = Index.create!(:name => 'dowjones')
        
        IndexDataLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/functional/index_data.csv', index, :skip_lines => 1)

        index = Index.find_by_name 'dowjones'
        index.prices.size.should eql(2)
        index.prices[0].date.should eql(Date.parse('2005-10-05'))
        index.prices[0].volume.should eql(1000)
        index.prices[0].open.should eql(BigDecimal.new('10434.81'))
        index.prices[0].close.should eql(BigDecimal.new('10317.36'))
        index.prices[0].high.should eql(BigDecimal.new('10438.47'))
        index.prices[0].low.should eql(BigDecimal.new('10316.16'))
        index.prices[0].change.should < 0
        index.prices[0].max_change.should > 0
        index.prices[0].prev_close.should eql(BigDecimal.new('10434.81'))
        
        index.prices[1].date.should eql(Date.parse('2005-10-06'))
        index.prices[1].volume.should eql(2000)
        index.prices[1].open.should eql(BigDecimal.new('10317.36'))
        index.prices[1].close.should eql(BigDecimal.new('10287.1'))
        index.prices[1].high.should eql(BigDecimal.new('10369.55'))
        index.prices[1].low.should eql(BigDecimal.new('10218.09'))
        index.prices[1].prev_close.should eql(BigDecimal.new('10317.36'))
        
        dates = MarketDate.all
        dates.size.should eql(2)
      end
      
      it "should skip duplicate line (has same date as previous line)" do
        index = Index.create!(:name => 'dowjones')
        
        IndexDataLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/functional/index_data_dup_lines.csv', index, :skip_lines => 1)
        
        index = Index.find_by_name 'dowjones'
        index.prices.size.should eql(1)
      end
      
      it "should populate index dates table" do
        index = Index.create!(:name => 'dowjones')
        
        IndexDataLoader.load_from_file(
          RAILS_ROOT + '/spec/fixtures/functional/index_data.csv', index, :skip_lines => 1)
          
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