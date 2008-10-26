require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe StockPrice do
  before :each do
    @market = Market.create!(:name => :a_market)
    @stock = Stock.create!(:market => @market, :name => :stock)
  end

  it "should have date, volume, open, close, high, low, change, max_change" do
    stock_price = StockPrice.create!(:stock => @stock,
      :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200,
      :high => 300, :low => 50, :change => 1, :max_change => 2.5)
    price = StockPrice.find(stock_price.id)
    price.stock.should eql(@stock)
    price.date.strftime.should eql('2008-01-01')
    price.volume.should eql(1000)
    price.open.should eql(BigDecimal.new('100'))
    price.close.should eql(BigDecimal.new('200'))
    price.high.should eql(BigDecimal.new('300'))
    price.low.should eql(BigDecimal.new('50'))
    price.change.should eql(BigDecimal.new('1'))
    price.max_change.should eql(BigDecimal.new('2.5'))
  end
  
  it "should get prices between dates" do
    StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = StockPrice.between('2008-1-2', '2008-1-3')
    prices.size.should eql(2)
    prices[0].date.should eql(Date.parse('2008-01-02'))
    prices[1].date.should eql(Date.parse('2008-01-03'))
  end
  
  describe 'change_between' do
    before :each do
      StockPrice.create!(:stock => @stock, :date => '1/1/2008', :change => 0.1)
      StockPrice.create!(:stock => @stock, :date => '1/2/2008', :change => 0.2)
      StockPrice.create!(:stock => @stock, :date => '1/3/2008', :change => 0)
      StockPrice.create!(:stock => @stock, :date => '1/4/2008', :change => 0.1)
    end      

    it "should get prices whose changes are between low and high" do
      prices = Stock.find(@stock.id).prices.change_between(0.1, 0.2)
      prices.size.should eql(3)
    end
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
  
  it "should include ModelWithDate module" do
    StockPrice.included_modules.should include(ModelWithDate)
  end
  
  it "should include ModelWithChange module" do
    StockPrice.included_modules.should include(ModelWithChange)
  end
  
  it "report_class should return StockPriceReport" do
    StockPrice.report_class.should eql("StockPriceReport")
  end
  
  it "should define named scope 'stock'" do
    StockPrice.stock(@stock)
  end
end

