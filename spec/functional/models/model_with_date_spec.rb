require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe ModelWithDate do
  it "is included in StockPrice" do
    StockPrice.included_modules.should include(ModelWithDate)
  end
  
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
    StockPrice.between('1/2/2008', '1/3/2008')
  end
  
  it "'between' takes Date object" do
    StockPrice.between(Date.parse('1/2/2008'), Date.parse('1/3/2008'))
  end
  
  it "should define named scope 'after'" do
    StockPrice.after('1/1/2008')
  end
  
  it "'after' takes Date object" do
    StockPrice.after(Date.parse('1/1/2008'))
  end
  
  it "should define named scope 'before'" do
    StockPrice.before('1/1/2008')
  end
  
  it "'before' takes Date object" do
    StockPrice.before(Date.parse('1/1/2008'))
  end
end