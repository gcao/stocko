require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe RAILS_ROOT + '/app/mixins/object.rb' do
  it "adds nil_or method to Object" do
    obj = Object.new
    obj.nil_or.to_s.should eql(obj.to_s)
    nil.nil_or.some_method.should eql(nil)
  end
  
  it "should include Report module" do
    Object.included_modules.should include(Report)
  end
end
