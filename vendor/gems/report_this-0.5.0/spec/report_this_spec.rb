require File.dirname(__FILE__) + '/spec_helper'

require 'report_this'

describe ReportThis do
  it "should add report_class method to Object class" do
    Object.respond_to?(:report_class).should be_true
  end
  
  it "should add report method to Object instance" do
    Object.new.respond_to?(:report).should be_true
  end
  
  it "report_class sets class to use" do
    Object.report_class 'TestReport'
    Object.report_class.should == 'TestReport'
  end
end