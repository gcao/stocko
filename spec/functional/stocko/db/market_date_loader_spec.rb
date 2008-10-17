require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Db
    describe MarketDateLoader do
      it "should load dates into market dates table" do
        loader = MarketDateLoader.new
        loader.append('1/2/2008')
        loader.append('1/3/2008')
        loader.append('2/1/2008')
        loader.finish
        dates = MarketDate.all
        dates.size.should eql(3)
        dates[0].date.should eql(Date.parse('2008-1-2'))
        dates[0].next.date.should eql(Date.parse('2008-1-3'))
        dates[0].year.should eql(2008)
        dates[0].month.should eql(1)
        dates[0].first_of_month.should be_true
        dates[0].last_of_month.should be_false
        dates[1].date.should eql(Date.parse('2008-1-3'))
        dates[1].prev.date.should eql(Date.parse('2008-1-2'))
        dates[1].next.date.should eql(Date.parse('2008-2-1'))
        dates[1].year.should eql(2008)
        dates[1].month.should eql(1)
        dates[1].first_of_month.should be_false
        dates[1].last_of_month.should be_true
        dates[2].date.should eql(Date.parse('2008-2-1'))
        dates[2].prev.date.should eql(Date.parse('2008-1-3'))
        dates[2].year.should eql(2008)
        dates[2].month.should eql(2)
        dates[2].first_of_month.should be_true
        dates[2].last_of_month.should be_true
      end
    end
  end
end
