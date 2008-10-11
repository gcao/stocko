require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe MarketData do
  before :all do
    @market = Market.create!(:name => :a_market)
  end

  it "should have date, open, close, high, low" do
    market_data = MarketData.create!(
      :market => @market,
      :date => '1/1/2008',
      :volume => 1000,
      :open => 10000,
      :close => 10200,
      :high => 10300,
      :low => 10050)
    MarketData.find(market_data.id).should do |p|
      p.market.should eql(@market)
      p.date.should eql('1/1/2008')
      p.volume.should eql(1000)
      p.open.should eql(10000)
      p.close.should eql(10200)
      p.high.should eql(10300)
      p.low.should eql(10050)
    end
  end

end