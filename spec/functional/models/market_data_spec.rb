require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe MarketData do
  before :each do
    @market = Market.create!(:name => :a_market)
  end

  it "should have date, open, close, high, low, change, max_change" do
    market_data = MarketData.create!(:market => @market, :date => '1/1/2008', :volume => 1000,
      :open => 10000, :close => 10200, :high => 10300, :low => 10050, :change => 0.2, :max_change => 0.5)
    data = MarketData.find(market_data.id)
    data.market.should eql(@market)
    data.date.strftime.should eql('2008-01-01')
    data.volume.should eql(1000)
    data.open.should eql(BigDecimal.new('10000'))
    data.close.should eql(BigDecimal.new('10200'))
    data.high.should eql(BigDecimal.new('10300'))
    data.low.should eql(BigDecimal.new('10050'))
    data.change.should eql(BigDecimal.new('0.2'))
    data.max_change.should eql(BigDecimal.new('0.5'))
  end
  
  it "should get data between dates" do
    MarketData.create!(:market => @market, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    data = Market.find(@market.id).data.between('2008-1-2', '2008-01-03')
    data.size.should eql(2)
    data[0].date.strftime.should eql('2008-01-02')
    data[1].date.strftime.should eql('2008-01-03')
  end
  
  it "should return next day's market data" do
    market = MarketData.create!(:market => @market, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    market.next.date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return next n days' market datas" do
    market = MarketData.create!(:market => @market, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    data = market.next(2)
    data[0].date.should eql(Date.parse('1/2/2008'))
    data[1].date.should eql(Date.parse('1/3/2008'))
  end
  
  it "should return prev day's market data" do
    MarketData.create!(:market => @market, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    market = MarketData.create!(:market => @market, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    market.prev.date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should return prev n days' market datas" do
    MarketData.create!(:market => @market, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/2/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    MarketData.create!(:market => @market, :date => '1/3/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    market = MarketData.create!(:market => @market, :date => '1/4/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50)
    
    data = market.prev(2)
    data[0].date.should eql(Date.parse('1/3/2008'))
    data[1].date.should eql(Date.parse('1/2/2008'))
  end
  
  it "should include Change module" do
    MarketData.included_modules.should include(Change)
  end
  
  it "should include ModelWithDate module" do
    MarketData.included_modules.should include(ModelWithDate)
  end
  
  it "should include ModelWithChange module" do
    MarketData.included_modules.should include(ModelWithChange)
  end
  
  it "to_s should return formatted string" do
    market_data = MarketData.create!(:market => @market,
      :date => '1/1/2008', :volume => 100000000, :open => 10000, :close => 12000.5,
      :high => 13000.05, :low => 9500, :change => -0.0134, :max_change => 0.025)
    market_data.to_s.should eql("2008-01-01  100,000,000  10000.00  12000.50  13000.05   9500.00     -1.34%      2.50%\n")
  end
  
  it "report_header" do
    MarketData.report_header.should eql(
      "1 Date         2 Volume    3 Open   4 Close    5 High     6 Low   7 Change  8 MAX Chg\n")
  end
end