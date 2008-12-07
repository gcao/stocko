require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'bigdecimal'
require File.expand_path(File.dirname(__FILE__) + '/../../lib/report_this/base')

module ReportThis
  describe Base do
    it "initializer takes model as first argument" do
      report = Base.new 'test'
      report.instance_variable_get(:'@model').should eql('test')
    end

    it "initializer takes optional config as second argument" do
      config = ReportThis::Config.new
      report = Base.new 'test', config
      report.instance_variable_get(:'@config').should eql(config)
    end

    it "should return report model" do
      Base.new('test').model.should eql('test')
    end

    it "should return report config" do
      config = ReportThis::Config.new
      report = Base.new 'test', config
      report.config.should eql(config)
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

    it "to_s should return header + body + footer" do
      class TestReport < Base
        def header; 'header'; end
        def body; 'body'; end
        def footer; 'footer'; end
      end
      TestReport.new('test').to_s.should eql('headerbodyfooter')
    end

    describe "default implementation" do
      it "nil" do
        report = Base.new nil
        report.header.should eql("<NilClass>\n")
        report.body.should eql("nil\n")
        report.footer.should be_nil
      end

      it "String" do
        report = Base.new 'test'
        report.header.should eql("<String>\n")
        report.body.should eql("test\n")
        report.footer.should be_nil
      end
    end
  end
end