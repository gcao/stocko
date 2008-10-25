require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe RAILS_ROOT + '/app/mixins/array.rb' do
  before :each do
    @array = Array.new
  end
  
  it "should include Change module" do
    Array.included_modules.should include(Change)
  end
  
  describe 'array of stocks' do
    before :each do
      @array << Stock.new(:name => 'stock1')
      @array << Stock.new(:name => 'stock2')
    end
    
    it "array_of_stocks? is true" do
      @array.array_of_stocks?.should be_true
    end
    
    it "array_of_market_data? is not true" do
      @array.array_of_market_data?.should_not be_true
    end
    
    it "array_of_stock_prices? is not true" do
      @array.array_of_stock_prices?.should_not be_true
    end

    [:volume, :open, :close, :high, :low, :change, :max_change, :start_date, :end_date].each do |method|
      it "should raise error on #{method}" do
        begin
          @array.send(method)
          fail "#{method} is not supported on array of stocks"
        rescue NotImplementedError
        end
      end
    end
  end
  
  describe 'array of market data' do 
    before :each do
      @array << MarketData.new(:date => '1/1/2008', :volume => 1000, :open => 100, :close => 210, :high => 330, :low => 50)
      @array << MarketData.new(:date => '1/2/2008', :volume => 1200, :open => 100, :close => 200, :high => 300, :low => 70)
      @array << MarketData.new(:date => '1/3/2008', :volume => 1400, :open => 130, :close => 220, :high => 300, :low => 60)
    end
    
    it "array_of_stocks? is not true" do
      @array.array_of_stocks?.should_not be_true
    end
    
    it "array_of_market_data? is true" do
      @array.array_of_market_data?.should be_true
    end
    
    it "array_of_stock_prices? is not true" do
      @array.array_of_stock_prices?.should_not be_true
    end
  end
  
  describe 'array of stock prices' do
    before :each do
      @array << StockPrice.new(:date => '1/1/2008', :volume => 1000, :open => 100, :close => 210, :high => 330, :low => 50)
      @array << StockPrice.new(:date => '1/2/2008', :volume => 1200, :open => 100, :close => 200, :high => 300, :low => 70)
      @array << StockPrice.new(:date => '1/3/2008', :volume => 1400, :open => 130, :close => 220, :high => 300, :low => 60)
    end
    
    it "array_of_stocks? is not true" do
      @array.array_of_stocks?.should_not be_true
    end
    
    it "array_of_market_data? is not true" do
      @array.array_of_market_data?.should_not be_true
    end
    
    it "array_of_stock_prices? is true" do
      @array.array_of_stock_prices?.should be_true
    end
    
    it "return average volume" do
      @array.volume.should eql(1200)
    end
    
    it "returns open of first day" do
      @array.open.should eql(100)
    end
    
    it "returns close of last day" do
      @array.close.should eql(220)
    end
    
    it "returns high of all days" do
      @array.high.should eql(330)
    end
    
    it "returns low of all days" do
      @array.low.should eql(50)
    end
    
    it "returns change" do
      @array.change.should eql(BigDecimal.new('1.2'))
    end
    
    it "returns max change" do
      @array.max_change.should eql(BigDecimal.new('2.8'))
    end
    
    it "returns first date" do
      @array.start_date.should eql(Date.parse('1/1/2008'))
    end
    
    it "returns end date" do
      @array.end_date.should eql(Date.parse('1/3/2008'))
    end
  end

  describe "group_by_date" do
    before :each do
      date_loader = Stocko::Db::MarketDateLoader.new
      date_loader.append('1/1/2008')
      date_loader.append('1/2/2008')
      date_loader.append('1/3/2008')
      date_loader.append('1/4/2008')
      date_loader.append('1/5/2008')
    end
    
    it "empty array returns self" do
      [].group_by_date.should eql([])
    end
    
    it "array with one element returns self" do
      [1].group_by_date.should eql([1])
    end

    describe "array of stock prices" do
      before :each do
        market = Market.create!(:name => 'market')
        @stock = Stock.create!(:market => market, :name => 'stock')
      end
      
      it "return self if there is only one group" do
        array = [] 
        array << StockPrice.create!(:stock => @stock, :date => '1/2/2008')
        array << StockPrice.create!(:stock => @stock, :date => '1/3/2008')
        array << StockPrice.create!(:stock => @stock, :date => '1/4/2008')

        prices = StockPrice.all

        groups = prices.group_by_date
        groups.should eql(array)
      end

      it "return multiple groups" do
        array = [] 
        array << StockPrice.create!(:stock => @stock, :date => '1/2/2008')
        array << StockPrice.create!(:stock => @stock, :date => '1/3/2008')
        array << StockPrice.create!(:stock => @stock, :date => '1/5/2008')

        prices = StockPrice.all

        groups = prices.group_by_date
        groups.size.should eql(2)
        groups[0].size.should eql(2)
        groups[0][0].date.should eql(Date.parse('1/2/2008'))
        groups[0][1].date.should eql(Date.parse('1/3/2008'))
        groups[1].size.should eql(1)
        groups[1][0].date.should eql(Date.parse('1/5/2008'))
      end
    end

    describe "array of market data" do
      before :each do
        @market = Market.create!(:name => 'market')
      end
      
      it "return self if there is only one group" do
        array = [] 
        array << MarketData.create!(:market => @market, :date => '1/2/2008')
        array << MarketData.create!(:market => @market, :date => '1/3/2008')
        array << MarketData.create!(:market => @market, :date => '1/4/2008')

        groups = MarketData.all.group_by_date
        groups.should eql(array)
      end

      it "return multiple groups" do
        array = [] 
        array << MarketData.create!(:market => @market, :date => '1/2/2008')
        array << MarketData.create!(:market => @market, :date => '1/3/2008')
        array << MarketData.create!(:market => @market, :date => '1/5/2008')

        groups = MarketData.all.group_by_date
        groups.size.should eql(2)
        groups[0].size.should eql(2)
        groups[0][0].date.should eql(Date.parse('1/2/2008'))
        groups[0][1].date.should eql(Date.parse('1/3/2008'))
        groups[1].size.should eql(1)
        groups[1][0].date.should eql(Date.parse('1/5/2008'))
      end
    end
    
    describe "sort" do
      it "should sort" do
        pending "not implemented"
      end
      
      it "can not call group_by_date if not sorted by dates" do
        pending "not implemented"
      end
    end
  end
end