require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe IndexPrice do
  before :each do
    @stock_index = StockIndex.create!(:name => :a_stock_index)
  end

  it "should have date, open, close, high, low, change, max_change" do
    price = IndexPrice.create!(:stock_index => @stock_index, :date => '1/1/2008', :volume => 1000,
      :open => 10000, :close => 10200, :high => 10300, :low => 10050, :change => 0.2, :max_change => 0.5)
    price.reload
    price.stock_index.should eql(@stock_index)
    price.date.strftime.should eql('2008-01-01')
    price.volume.should eql(1000)
    price.open.should eql(BigDecimal.new('10000'))
    price.close.should eql(BigDecimal.new('10200'))
    price.high.should eql(BigDecimal.new('10300'))
    price.low.should eql(BigDecimal.new('10050'))
    price.change.should eql(BigDecimal.new('0.2'))
    price.max_change.should eql(BigDecimal.new('0.5'))
  end
  
  it "should get prices between dates" do
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = StockIndex.find(@stock_index.id).prices.between('2008-1-2', '2008-01-03')
    prices.size.should eql(2)
    prices[0].date.strftime.should eql('2008-01-02')
    prices[1].date.strftime.should eql('2008-01-03')
  end
  
  it "should return next day's stock_index prices" do
    price = IndexPrice.create!(:stock_index => @stock_index, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    price.next.date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return next n days' stock_index pricess" do
    price = IndexPrice.create!(:stock_index => @stock_index, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = price.next(2)
    prices[0].date.should eql(Date.parse('1/2/2008'))
    prices[1].date.should eql(Date.parse('1/3/2008'))
  end
  
  it "should return prev day's stock_index prices" do
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    price = IndexPrice.create!(:stock_index => @stock_index, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    price.prev.date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return prev n days' stock_index pricess" do
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    IndexPrice.create!(:stock_index => @stock_index, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    price = IndexPrice.create!(:stock_index => @stock_index, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    prices = price.prev(2)
    prices[0].date.should eql(Date.parse('1/3/2008'))
    prices[1].date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should include Change module" do
    IndexPrice.included_modules.should include(Change)
  end
  
  it "should include ModelWithDate module" do
    IndexPrice.included_modules.should include(ModelWithDate)
  end
  
  it "should include ModelWithChange module" do
    IndexPrice.included_modules.should include(ModelWithChange)
  end
end