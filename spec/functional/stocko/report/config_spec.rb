require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Report
    describe Config do
      it "initializer can be called without argument" do
        Stocko::Report::Config.new
      end
      
      it "initializer takes options hash" do
        Stocko::Report::Config.new :key => 'value'
      end
      
      it "initializer converts option keys to symbols" do
        config = Stocko::Report::Config.new 'key' => 'value'
        config[:key].should eql('value')
      end
      
      it "can access options" do
        config = Stocko::Report::Config.new :key => 'value'
        config[:key].should eql('value')
      end
      
      it "Default page size is 20" do
        Stocko::Report::Config.new[:page_size].should eql(20)
      end
      
      it "returns default instance" do
        Stocko::Report::Config.default[:page_size].should eql(Stocko::Report::Config::DEFAULT_OPTIONS[:page_size])
      end
    end
  end
end
