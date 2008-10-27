require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe Market do
  it "should have name, description" do
    market = Market.new(:name => 'a_market', :description => 'a_description')
    market.save
    saved_market = Market.find(market.id)
    saved_market.name.should eql('a_market')
    saved_market.description.should eql('a_description')
  end
  
  it "market name should not be blank" do
    market = Market.new(:name => "", :description => 'a_description')
    market.save.should be_false
    market.errors.on(:name).should_not be_nil
  end
  
  it "market can have n stocks" do
    market = Market.create!(:name => 'a_market')
    Stock.create!(:market => market, :name => 'stocka')
    Stock.create!(:market => market, :name => 'stockb')
    saved_market = Market.find(market.id)
    saved_market.stocks[0].name.should eql('stocka')
    saved_market.stocks[1].name.should eql('stockb')
  end
  
  it "market can have n days of data" do
    market = Market.create!(:name => 'a_market')
    MarketData.create!(:market => market, :date => '1/1/2008')
    MarketData.create!(:market => market, :date => '1/2/2008')
    saved_market = Market.find(market.id)
    saved_market.data[0].date.strftime.should eql('2008-01-01')
    saved_market.data[1].date.strftime.should eql('2008-01-02')
  end
  
  it "to_s returns market name" do
    Market.new(:name => 'abc').to_s.should eql('abc')
  end
  
  it "class methods returns named market objects" do
    market = Market.create!(:name => 'xxx', :description => 'a_description')
    Market.xxx.name.should eql('xxx')
    Market.xxx.description.should eql('a_description')
  end
  
  it "defines named scope 'market'" do
    market = Market.create!(:name => 'xxx', :description => 'a_description')
    expected = {:conditions => ['market_id = ?', market.id]}
    MarketData.market(market).proxy_options.should == expected # eql() does not work here !!!
  end
end