require File.expand_path(File.dirname(__FILE__) + '/../../functional_spec_helper')

describe Stocko::Db::Yahoo::IndustryLoader do
  before :each do
    @sector = Sector.first
  end
  
  it "should read yahoo sector page and load industries" do
  end
end