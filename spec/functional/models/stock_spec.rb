require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe Stock do
  before :all do
    @market = Market.create!(:name => :a_market)
  end

  after :all do
    @market.destroy
  end

  describe "valid" do

    it "should have name, description" do
      stock = Stock.create!(:market => @market, :name => :stock, :description => :a_description)
      Stock.find(stock.id).should do |s|
        s.name.should eql('stock')
        s.description.should eql('a_description')
      end
    end

  end

  describe "invalid" do

    it "stock name should not be blank" do
      stock = Stock.new(:market => @market, :name => '', :description => :a_description)
      stock.save.should be_false
      stock.errors.on(:name).should_not be_nil
    end

    it "stock name should contains alphabetic characters only" do
      stock = Stock.new(:market => @market, :name => :a123, :description => :a_description)
      stock.save.should be_false
      stock.errors.on(:name).should_not be_nil
    end

  end

  describe "associations" do

    it "can have n prices" do
      stock = Stock.create!(:market => @market, :name => :stock, :description => :a_description)
      stock.save
      StockPrice.create!(:stock => stock, :date => '1/1/2008')
      StockPrice.create!(:stock => stock, :date => '1/2/2008')
      Stock.find(stock.id).prices.should do |p|
        p[0].date.should eql('1/1/2008')
        p[1].date.should eql('1/2/2008')
      end
    end

  end
end