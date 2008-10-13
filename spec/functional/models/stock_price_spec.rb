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
    StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = Stock.find(@stock.id).prices.between('2008-1-2', '2008-01-03')
    prices.size.should eql(2)
    prices[0].date.should eql(Date.parse('2008-01-02'))
    prices[1].date.should eql(Date.parse('2008-01-03'))
  end
  
  it "should return next day's stock price" do
    stock = StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    stock.next.date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return next n days' stock prices" do
    stock = StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = stock.next(2)
    prices[0].date.should eql(Date.parse('1/2/2008'))
    prices[1].date.should eql(Date.parse('1/3/2008'))
  end
  
  it "should return prev day's stock price" do
    StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    stock = StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    stock.prev.date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return prev n days' stock prices" do
    StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    stock = StockPrice.create!(:stock => @stock, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = stock.prev(2)
    prices[0].date.should eql(Date.parse('1/3/2008'))
    prices[1].date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should include Change module" do
    StockPrice.included_modules.should include(Change)
  end
end

