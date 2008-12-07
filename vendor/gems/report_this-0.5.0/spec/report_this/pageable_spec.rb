require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'report_this/config'
require 'report_this/base'
require 'report_this/pageable'

module ReportThis
  describe Pageable do
    before :each do
      @array = %w[one two three four five six]
      config = ReportThis::Config.new :page_size => 5
      class TestReport < ReportThis::Base
        include Pageable
      end
      @report = TestReport.new @array, config
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

    it "next_page does not change page if already on last page" do
      @report.next_page
      @report.page_number.should eql(2)
      @report.next_page
      @report.page_number.should eql(2)
    end

    it "prev_page returns self" do
      @report.prev_page.should eql(@report)
    end

    it "prev_page changes page" do
      @report.next_page
      @report.page_number.should eql(2)
      @report.prev_page
      @report.page_number.should eql(1)
    end

    it "prev_page does not change page if already on first page" do
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
end
