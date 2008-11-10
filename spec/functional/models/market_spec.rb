require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe Market do
  describe "valid" do

    it "should have name, description" do
      market = Market.create!(:name => 'market', :description => 'a_description')
      saved_market = Market.find(market.id)
      saved_market.name.should eql('market')
      saved_market.description.should eql('a_description')
    end

  end

  describe "invalid" do

    it "market name should not be blank" do
      market = Market.new(:name => '', :description => 'a_description')
      market.save.should be_false
      market.errors.on(:name).should_not be_nil
    end

    it "market name should contains alphabetic characters only" do
      market = Market.new(:name => 'a123', :description => 'a_description')
      market.save.should be_false
      market.errors.on(:name).should_not be_nil
    end

  end
end