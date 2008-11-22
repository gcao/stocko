require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require File.expand_path(File.dirname(__FILE__) + '/../../lib/report/config')

module Report
  describe Config do
    it "initializer can be called without argument" do
      Report::Config.new
    end

    it "initializer takes options hash" do
      Report::Config.new :key => 'value'
    end

    it "initializer converts option keys to symbols" do
      config = Report::Config.new 'key' => 'value'
      config[:key].should eql('value')
    end

    it "can access options" do
      config = Report::Config.new :key => 'value'
      config[:key].should eql('value')
    end

    it "Default page size is 20" do
      Report::Config.new[:page_size].should eql(20)
    end

    it "returns default instance" do
      Report::Config.default[:page_size].should eql(Report::Config::DEFAULT_OPTIONS[:page_size])
    end
  end
end
