require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe Market do
  it "should have name, description" do
    market = Market.new(:name => :a_market, :description => :a_description)
    market.save
    Market.find(market.id).should do |s|
      s.name.should eql('a_market')
      s.description.should eql('a_description')
    end
  end
  
  it "market name should not be blank" do
    market = Market.new(:name => "", :description => :a_description)
    market.save.should be_false
    market.errors.on(:name).should_not be_nil
  end
  
  it "market can have n stocks" do
    market = Market.create!(:name => :a_market)
    Stock.create!(:market => market, :name => :stocka)
    Stock.create!(:market => market, :name => :stockb)
    Market.find(market.id).should do |m|
      m.stocks[0].name.should eql('stocka')
      m.stocks[1].name.should eql('stockb')
    end
  end
  
  it "market can have n days of data" do
    market = Market.create!(:name => :a_market)
    MarketData.create!(:market => market, :date => '1/1/2008')
    MarketData.create!(:market => market, :date => '1/2/2008')
    Market.find(market.id).should do |m|
      m.data[0].date.should eql('1/1/2008')
      m.data[1].date.should eql('1/2/2008')
    end
  end
  
  it "to_s returns market name" do
    Market.new(:name => 'abc').to_s.should eql('abc')
  end
end