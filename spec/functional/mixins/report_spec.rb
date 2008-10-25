require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe RAILS_ROOT + '/app/mixins/report.rb' do
  before :all do
    class TestClass
      def to_s
        "test"
      end
    end
  end

  it "inherits a report method" do
    TestClass.new.respond_to? :report
  end
  
  it "returns nil report class" do
    TestClass.report_class.should be_nil
  end

  it "returns report" do
    TestClass.new.report.should eql("<TestClass>\ntest\n")
  end

  it "takes an optional report config" do
    TestClass.new.report(Stocko::Report::Config.new).should eql("<TestClass>\ntest\n")
  end
end

describe "customized report class" do
  before :all do
    class TestClass2Report < Stocko::Report::Base
      def header
        if @config[:colorize]
          "colorful header "
        else
          "header "
        end
      end

      def body
        if @config[:colorize]
          "colorful body "
        else
          "body "
        end
      end

      def footer
        if @config[:colorize]
          "colorful footer"
        else
          "footer"
        end
      end
    end

    class TestClass2
    end
  end
  
  it "report_class should discover report class" do
    TestClass2.report_class.should eql("TestClass2Report")
  end

  it "should render report using default report class" do
    TestClass2.new.report.should eql("header body footer")
  end

  it "should pass config to report class" do
    config = Stocko::Report::Config.new(:colorize => true)
    TestClass2.new.report(config).should eql("colorful header colorful body colorful footer")
  end
end
