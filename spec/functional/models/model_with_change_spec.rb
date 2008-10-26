require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe ModelWithChange do
  it "verify named scope option" do
    low = 0
    high = 0.5
    expected = {:conditions => ['change >= ? and change <= ?', low, high]}
    StockPrice.change_between(low, high).proxy_options.should == expected # eql() does not work here !!!
  end
  
  it "should define named scope 'between'" do
    StockPrice.included_modules.should include(ModelWithChange)
    StockPrice.change_between(0, 0.5)
  end
  
  it "should define named scope 'change_gt'" do
    StockPrice.included_modules.should include(ModelWithDate)
    StockPrice.change_gt(0.01)
  end
  
  it "should define named scope 'change_lt'" do
    StockPrice.included_modules.should include(ModelWithDate)
    StockPrice.change_lt(0.01)
  end
end