class Market < ActiveRecord::Base
  has_many :stocks, :dependent => :destroy
  has_many :data, :class_name => 'MarketData', :dependent => :destroy
  
  validates_presence_of :name
  
  def to_s
    name
  end
  
  def self.method_missing name, *args
    return super if name.to_s[0..3] == 'find'
      
    if market = find_by_name(name.to_s)
      define_method name do
        market 
      end
      market
    else
      super
    end
  end
end