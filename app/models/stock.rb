class Stock < ActiveRecord::Base
  belongs_to :market
  has_many :prices, :class_name => "StockPrice", :dependent => :destroy
  
  validates_format_of :name, :with => /^[a-z]+$/
end