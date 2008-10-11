class Market < ActiveRecord::Base
  has_many :stocks, :dependent => :destroy
  has_many :data, :class_name => 'MarketData', :dependent => :destroy
  
  validates_presence_of :name
  
  def to_s
    name
  end
end