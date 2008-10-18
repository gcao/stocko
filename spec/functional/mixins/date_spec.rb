require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe RAILS_ROOT + '/app/mixins/date.rb' do
  before :each do
    date_loader = Stocko::Db::MarketDateLoader.new
    date_loader.append('1/2/2008')
    date_loader.append('1/3/2008')
    date_loader.append('1/4/2008')
    date_loader.append('2/1/2008')
    @date = Date.parse('1/3/2008')
  end
  
  it "should return prev date" do
    @date.prev_date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return next date" do
    @date.next_date.should eql(Date.parse('1/4/2008'))
    @date.next_date.next_date.should eql(Date.parse('2/1/2008'))
  end

end