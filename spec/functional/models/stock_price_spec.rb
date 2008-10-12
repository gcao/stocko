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
    prices[0].date.strftime.should eql('2008-01-02')
    prices[1].date.strftime.should eql('2008-01-03')
  end
  
  it "should return next day's stock price" do
    stock = StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    stock.next.date.strftime.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return next n days' stock prices" do
    stock = StockPrice.create!(:stock => @stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    StockPrice.create!(:stock => @stock, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = stock.next(2)
    prices[0].date.strftime.should eql(Date.parse('1/2/2008'))
    prices[1].date.strftime.should eql(Date.parse('1/3/2008'))
  end
  
  describe "price change" do
    before :each do
      @price = StockPrice.new(:stock => @stock, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    end
    
    it "up?" do
      @price.up?.should be_true
    end
    
    it "down?" do
      @price.down?.should be_false
    end
    
    it "change" do
      @price.change.should eql(BigDecimal.new('1'))
    end
    
    it "max_change" do
      @price.max_change.should eql(BigDecimal.new('2.5'))
    end
  end

end

