require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe Stock do
  before :each do
    @market = Market.create!(:name => :a_market)
  end

  describe "valid" do

    it "should have name, description" do
      stock = Stock.create!(:market => @market, :name => 'stock', :description => 'a_description')
      saved_stock = Stock.find(stock.id)
      saved_stock.name.should eql('stock')
      saved_stock.description.should eql('a_description')
    end

  end

  describe "invalid" do

    it "stock name should not be blank" do
      stock = Stock.new(:market => @market, :name => '', :description => 'a_description')
      stock.save.should be_false
      stock.errors.on(:name).should_not be_nil
    end

    it "stock name should contains alphabetic characters only" do
      stock = Stock.new(:market => @market, :name => 'a123', :description => 'a_description')
      stock.save.should be_false
      stock.errors.on(:name).should_not be_nil
    end

  end

  describe "associations" do

    it "can have n prices" do
      stock = Stock.create!(:market => @market, :name => 'stock', :description => 'a_description')
      stock.save
      StockPrice.create!(:stock => stock, :date => '1/1/2008')
      StockPrice.create!(:stock => stock, :date => '1/2/2008')
      prices = Stock.find(stock.id).prices
      prices[0].date.strftime.should eql('2008-01-01')
      prices[1].date.strftime.should eql('2008-01-02')
    end

  end
end