require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe MarketData do
  before :each do
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
    data = MarketData.find(market_data.id)
    data.market.should eql(@market)
    data.date.strftime.should eql('2008-01-01')
    data.volume.should eql(1000)
    data.open.should eql(BigDecimal.new('10000'))
    data.close.should eql(BigDecimal.new('10200'))
    data.high.should eql(BigDecimal.new('10300'))
    data.low.should eql(BigDecimal.new('10050'))
  end

end