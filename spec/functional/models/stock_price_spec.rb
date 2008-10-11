require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe StockPrice do
  before :each do
    @market = Market.create!(:name => :a_market)
    @stock = Stock.create!(:market => @market, :name => :stock)
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
    price = StockPrice.find(stock_price.id)
    price.stock.should eql(@stock)
    price.date.strftime.should eql('2008-01-01')
    price.volume.should eql(1000)
    price.open.should eql(BigDecimal.new('100'))
    price.close.should eql(BigDecimal.new('200'))
    price.high.should eql(BigDecimal.new('300'))
    price.low.should eql(BigDecimal.new('50'))
  end
  
  it "should get prices between dates" do
    stock_price = StockPrice.create!(:stock => @stock, :date => '1/1/2008', 
      :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    stock_price = StockPrice.create!(:stock => @stock, :date => '1/2/2008', 
      :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    stock_price = StockPrice.create!(:stock => @stock, :date => '1/3/2008', 
      :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    stock_price = StockPrice.create!(:stock => @stock, :date => '1/4/2008', 
      :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = Stock.find(@stock.id).prices.between('2008-1-2', '2008-01-03')
    prices.size.should eql(2)
    prices[0].date.should eql('1/2/2008')
    prices[1].date.should eql('1/3/2008')
  end
end

