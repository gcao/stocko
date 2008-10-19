require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Report
    describe Base do
      it "initializer takes model as first argument" do
        report = Base.new 'test'
        report.instance_variable_get(:'@model').should eql('test')
      end
      
      it "initializer takes optional config as second argument" do
        config = Stocko::Report::Config.new
        report = Base.new 'test', config
        report.instance_variable_get(:'@config').should eql(config)
      end
      
      it "should return report header" do
        Base.new('test').respond_to?(:header).should be_true
      end
      
      it "should return report body" do
        Base.new('test').respond_to?(:body).should be_true
      end
      
      it "should return report footer" do
        Base.new('test').respond_to?(:footer).should be_true
      end
    end
  end
end
