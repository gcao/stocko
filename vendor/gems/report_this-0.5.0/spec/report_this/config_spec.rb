require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'report_this/config'

module ReportThis
  describe Config do
    it "initializer can be called without argument" do
      ReportThis::Config.new
    end

    it "initializer takes options hash" do
      ReportThis::Config.new :key => 'value'
    end

    it "initializer converts option keys to symbols" do
      config = ReportThis::Config.new 'key' => 'value'
      config[:key].should eql('value')
    end

    it "can access options" do
      config = ReportThis::Config.new :key => 'value'
      config[:key].should eql('value')
    end

    it "Default page size is 20" do
      ReportThis::Config.new[:page_size].should eql(20)
    end

    it "returns default instance" do
      ReportThis::Config.default[:page_size].should eql(ReportThis::Config::DEFAULT_OPTIONS[:page_size])
    end
  end
end
