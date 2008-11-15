require File.expand_path(File.dirname(__FILE__) + '/../../../functional_spec_helper')

describe Stocko::Db::Yahoo::StockLoader do
  before :each do
    @industry = Factory(:industry_gold, :sector => Factory(:sector_materials))
    @loader = Stocko::Db::Yahoo::StockLoader.new
  end
  
  it "should read yahoo industry page and load stocks" do
    @loader.load_from_industry @industry
    @industry.reload
    @industry.stocks.size.should > 0
  end
end