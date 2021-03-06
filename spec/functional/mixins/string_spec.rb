require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe RAILS_ROOT + '/app/mixins/string.rb' do
  it "commify add comma to string" do
    "1000".commify.should eql('1,000')
    "1000000".commify.should eql('1,000,000')
    "1000000000".commify.should eql('1,000,000,000')
  end
  
  it "should return line count" do
    "a\nb".line_count.should eql(2)
    "a\nb\n".line_count.should eql(2)
  end
  
  it "should return class" do
    "Object".to_class.should eql(Object)
  end
  
  it "should return class in module" do
    module M
      class C
      end
    end
    
    "M::C".to_class.should eql(M::C)
  end
end
