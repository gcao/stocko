require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

describe "report for array" do
  before :each do
    stock = Stock.create!(:name => :stock)
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
      @report.footer.should eql("Page 1/1      1 - 6 of 6 rows\n")
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
    
    it "next_page returns self" do
      @report.next_page.should eql(@report)
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
    
    it "prev_page returns self" do
      @report.prev_page.should eql(@report)
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
    
    it "goto_page returns self" do
      @report.goto_page(2).should eql(@report)
    end
    
    it "goto_page go to specified page" do
      @report.goto_page(2)
      @report.page_number.should eql(2)
    end
    
    it "goto_page go to last page if page number is greater than number of pages" do
      @report.goto_page 3
      @report.page_number.should eql(2)
    end
  end

  describe "colorful report" do
    before :each do
      @config = Stocko::Report::Config.new :colorize => true
      @report = ArrayReport.new @array, @config
    end

    it "report header should be the same as stock price report header" do
      @report.header.should eql(StockPriceReport.new(@array[0], @config).header)
    end

    it "report body should contains stock price bodies" do
      @report.body.should eql(@array.map{|elem| StockPriceReport.new(elem, @config).body}.join)
    end

    it "report footer should output array size, page number, total pages etc" do
      @report.footer.should eql("\033[36mPage 1/1      1 - 6 of 6 rows\033[0m\n")
    end
  end
end

describe "array of objects that uses default report" do
  before :each do
    @array = ["a", "b", "c"]
  end
  
  it "returns header" do
    @array.report.header.should eql(@array[0].report.header)
  end
  
  it "returns body" do
    @array.report.body.should eql("a\nb\nc\n")
  end
end

describe "empty array" do
  before :each do
    @array = []
  end
  
  it { @array.report.header.should eql("<Empty Array>\n") }
  it { @array.report.body.should be_nil }
  it { @array.report.footer.should be_nil }
end
