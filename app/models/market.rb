class Market < ActiveRecord::Base
  has_many :stocks, :dependent => :destroy
  has_many :market_data, :class_name => 'MarketData', :dependent => :destroy
  
  validates_presence_of :name
end