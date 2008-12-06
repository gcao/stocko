require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require File.expand_path(File.dirname(__FILE__) + '/../../lib/report_this')

module ReportThis
  describe Pageable do
    before :each do
      @array = %w[one two three four five six]
      config = ReportThis::Config.new :page_size => 5
      @report = ArrayReport.new @array, config
    end
    
    it "header" do
      @report.header.should eql("<String>")
    end
  end
end
