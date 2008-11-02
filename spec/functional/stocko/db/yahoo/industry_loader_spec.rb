require File.expand_path(File.dirname(__FILE__) + '/../../../functional_spec_helper')

describe Stocko::Db::Yahoo::IndustryLoader do
  before :each do
    @sector = Factory(:sector)
    @loader = Stocko::Db::Yahoo::IndustryLoader.new
  end
  
  it "should read yahoo sector page and load industries" do
    @loader.load_from_sector @sector
    @sector.reload
    @sector.industries.size.should > 0
  end
end