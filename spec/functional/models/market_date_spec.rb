require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe MarketDate do
  it "should have date, prev, next, year, month, first_of_month, last_of_month" do
    date = MarketDate.create!(:date => '1/2/2008', :year => 2008, :month => 1, :first_of_month => true, :last_of_month => false)
    date2 = MarketDate.create!(:prev => date, :date => '1/3/2008', :year => 2008, :month => 1, :first_of_month => false, :last_of_month => false)
    date.next = date2
    date.save!
    found_date = MarketDate.find_by_date(Date.parse('1/2/2008'))
    found_date.year.should eql(2008)
    found_date.month.should eql(1)
    found_date.first_of_month.should be_true
    found_date.last_of_month.should be_false
    found_date.next.date.should eql(Date.parse('1/3/2008'))
    found_date2 = MarketDate.find_by_date(Date.parse('1/3/2008'))
    found_date2.year.should eql(2008)
    found_date2.month.should eql(1)
    found_date2.first_of_month.should be_false
    found_date2.last_of_month.should be_false
    found_date2.prev.date.should eql(Date.parse('1/2/2008'))
  end
end
