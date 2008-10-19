require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

module Stocko
  module Report
    describe Base do
      it "should return report header" do
        Base.new.respond_to?(:header).should be_true
      end
      
      it "should return report body" do
        Base.new.respond_to?(:body).should be_true
      end
      
      it "should return report footer" do
        Base.new.respond_to?(:footer).should be_true
      end
    end
  end
end
