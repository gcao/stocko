require File.expand_path(File.dirname(__FILE__) + '/../../../functional_spec_helper')

module Stocko
  module Report
    module Console
      describe MarketDataReport do
        before :each do
          market = Market.create!(:name => :a_market)
          @market_data = MarketData.create!(:market => market,
            :date => '1/1/2008', :volume => 100000000, :open => 10000, :close => 12000.5,
            :high => 13000.05, :low => 9500, :change => -0.0134, :max_change => 0.025)
        end
        
        it "should include CommonDailyReport module" do
          MarketDataReport.included_modules.should include(CommonDailyReport)
        end

        describe "default report" do
          before :each do
            @report = MarketDataReport.new @market_data
          end

          it "should return report header" do
            @report.header.should eql(
              "1 Date         2 Volume    3 Open   4 Close    5 High     6 Low   7 Change  8 MAX Chg\n")
          end

          it "should return report body" do
            @report.body.should eql(
              "2008-01-01  100,000,000  10000.00  12000.50  13000.05   9500.00     -1.34%      2.50%\n")
          end

          it "should return report footer" do
            @report.footer.should be_nil
          end
        end

        describe "colorful report" do
          before :each do
            config = Stocko::Report::Config.new :colorize => true
            @report = MarketDataReport.new @market_data, config
          end

          it "produce red report if change >= 1%" do
            @market_data.change = 0.02
            @report.body.should eql(
              "\033[31m2008-01-01  100,000,000  10000.00  12000.50  13000.05   9500.00      2.00%      2.50%\033[0m\n")
          end
  
          it "produce green report if change <= -1%" do
            @market_data.change = -0.02
            @report.body.should eql(
              "\033[32m2008-01-01  100,000,000  10000.00  12000.50  13000.05   9500.00     -2.00%      2.50%\033[0m\n")
          end
    
          it "should return report header" do
            @report.header.should eql(
              "\033[34m1 Date         2 Volume    3 Open   4 Close    5 High     6 Low   7 Change  8 MAX Chg\033[0m\n")
          end
        end
      end
    end
  end
end
