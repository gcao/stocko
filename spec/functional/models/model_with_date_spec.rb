require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe ModelWithDate do
  it "verify named scope option" do
    pending "#scope_options does not work"
    
    from = '1/2/2008'
    to = '1/3/2008'
    actual = StockPrice.between(from, to)
    expected = {:conditions => 
      {:between => ['date >= ? and date <= ?', Date.parse(from), Date.parse(to)]}
    }
    actual.scope_options.should eql(expected)
  end
  
  it "should define named scope 'between'" do
    StockPrice.included_modules.should include(ModelWithDate)
    StockPrice.between('1/2/2008', '1/3/2008')
  end
end