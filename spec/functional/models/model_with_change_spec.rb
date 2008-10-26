require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe ModelWithChange do
  it "verify named scope option" do
    pending "#scope_options does not work"
    
    low = 0
    high = 0.5
    actual = StockPrice.change_between(low, high)
    expected = {:conditions => 
      {:between => ['change >= ? and change <= ?', low, high]}
    }
    actual.scope_options.should eql(expected)
  end
  
  it "should define named scope 'between'" do
    StockPrice.included_modules.should include(ModelWithChange)
    StockPrice.change_between(0, 0.5)
  end
  
  it "should define named scope 'change_ge'" do
    StockPrice.included_modules.should include(ModelWithDate)
    StockPrice.change_gt(0.01)
  end
  
  it "should define named scope 'change_le'" do
    StockPrice.included_modules.should include(ModelWithDate)
    StockPrice.change_lt(0.01)
  end
end