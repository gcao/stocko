require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

describe StockPriceReport do
  before :each do
    market = Market.create!(:name => :a_market)
    stock = Stock.create!(:market => market, :name => :stock)
    @stock_price = StockPrice.new(:stock => stock,
      :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200,
      :high => 300, :low => 50, :change => 1, :max_change => 2.5)
  end
  
  it "should include CommonDailyReport module" do
    StockPriceReport.included_modules.should include(CommonDailyReport)
  end

  describe "default report" do
    before :each do
      @report = StockPriceReport.new @stock_price
    end

    it "should return report header" do
      @report.header.should eql(
        "1 Date         2 Volume    3 Open   4 Close    5 High     6 Low   7 Change  8 MAX Chg\n")
    end

    it "should return report body" do
      @report.body.should eql(
        "2008-01-01        1,000    100.00    200.00    300.00     50.00    100.00%    250.00%\n")
    end

    it "should return report footer" do
      @report.footer.should be_nil
    end
  end

  describe "colorful report" do
    before :each do
      config = Stocko::Report::Config.new :colorize => true
      @report = StockPriceReport.new @stock_price, config
    end

    it "produce red report if change >= 1%" do
      @stock_price.change = 0.02
      @report.body.should eql(
        "\033[31m2008-01-01        1,000    100.00    200.00    300.00     50.00      2.00%    250.00%\033[0m\n")
    end

    it "produce green report if change <= -1%" do
      @stock_price.change = -0.02
      @report.body.should eql(
        "\033[32m2008-01-01        1,000    100.00    200.00    300.00     50.00     -2.00%    250.00%\033[0m\n")
    end

    it "should return report header" do
      @report.header.should eql(
        "\033[34m1 Date         2 Volume    3 Open   4 Close    5 High     6 Low   7 Change  8 MAX Chg\033[0m\n")
    end
  end
end
