require File.expand_path(File.dirname(__FILE__) + '/../../../functional_spec_helper')

module Stocko
  module Report
    module Console
      describe "report for array of stock prices" do
        before :each do
          market = Market.create!(:name => :a_market)
          stock = Stock.create!(:market => market, :name => :stock)
          @array = []
          @array << StockPrice.new(:stock => stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50, :change => 1, :max_change => 2.5)
          @array << StockPrice.new(:stock => stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50, :change => 1, :max_change => 2.5)
          @array << StockPrice.new(:stock => stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50, :change => 1, :max_change => 2.5)
          @array << StockPrice.new(:stock => stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50, :change => 1, :max_change => 2.5)
          @array << StockPrice.new(:stock => stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50, :change => 1, :max_change => 2.5)
          @array << StockPrice.new(:stock => stock, :date => '1/1/2008', :volume => 1000, :open => 100, :close => 200, :high => 300, :low => 50, :change => 1, :max_change => 2.5)
        end

        describe "default report" do
          before :each do
            @report = ArrayReport.new @array
          end

          it "report header should be the same as stock price report header" do
            @report.header.should eql(StockPriceReport.new(@array[0]).header)
          end

          it "report body should contains stock price bodies" do
            @report.body.should eql(@array.map{|elem| StockPriceReport.new(elem).body}.join)
          end

          it "report footer should output array size, page number, total pages etc" do
            @report.footer.should eql("Page 1/1      1 - 6 of 6 rows")
          end
          
          it "return total pages" do
            @report.pages.should eql(1)
          end
          
          it "return 1-based page number" do
            @report.page_number.should eql(1)
          end
        end
        
        describe "paging" do
          before :each do
            config = Stocko::Report::Config.new :page_size => 5
            @report = ArrayReport.new @array, config
          end
          
          it "report body should contain current page's stock price bodies" do
            @report.body.should eql(@array[0, @report.config[:page_size]].map{|elem| StockPriceReport.new(elem).body}.join)
          end
          
          it "return total pages" do
            @report.pages.should eql(2)
          end
          
          it "next_page changes page number" do
            @report.next_page
            @report.page_number.should eql(2)
          end
          
          it "next_page does not page number if already on last page" do
            @report.next_page
            @report.page_number.should eql(2)
            @report.next_page
            @report.page_number.should eql(2)
          end
          
          it "prev_page changes page number" do
            @report.next_page
            @report.page_number.should eql(2)
            @report.prev_page
            @report.page_number.should eql(1)
          end
          
          it "prev_page does not change page number if already on first page" do
            @report.next_page
            @report.page_number.should eql(2)
            @report.prev_page
            @report.page_number.should eql(1)
            @report.prev_page
            @report.page_number.should eql(1)
          end
          
          it "goto_page go to specified page" do
            @report.goto_page 2
            @report.page_number.should eql(2)
          end
          
          it "goto_page go to last page if page number is greater than number of pages" do
            @report.goto_page 3
            @report.page_number.should eql(2)
          end
        end

        describe "colorful report" do
          before :each do
            config = Stocko::Report::Config.new :colorize => true
            @report = ArrayReport.new @array, config
          end

          it "report header should be the same as stock price report header" do
            pending "not implemented"
          end

          it "report body should contains stock price bodies" do
            pending "not implemented"
          end

          it "report footer should output array size, page number, total pages etc" do
            pending "not implemented"
          end
        end
      end
    end
  end
end
