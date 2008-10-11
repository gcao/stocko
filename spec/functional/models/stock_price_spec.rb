require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe StockPrice do
  before :all do
    @market = Market.create!(:name => :a_market)
    @stock = Stock.create!(:market => @market, :name => :stock)
  end

  after :all do
    @market.destroy
  end
  
  it "should have date, volume, open, close, high, low" do
    stock_price = StockPrice.create!(
      :stock => @stock,
      :date => '1/1/2008',
      :volume => 1000,
      :open => 100,
      :close => 200,
      :high => 300,
      :low => 50)
    StockPrice.find(stock_price.id).should do |p|
      p.stock.should eql(@stock)
      p.date.should eql('1/1/2008')
      p.volume.should eql(1000)
      p.open.should eql(100)
      p.close.should eql(200)
      p.high.should eql(300)
      p.low.should eql(50)
    end
  end
end

