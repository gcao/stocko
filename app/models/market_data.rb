class MarketData < ActiveRecord::Base
  include Change
  
  set_table_name "market_data"
  
  belongs_to :market
  
  named_scope :between, lambda{ |from, to|
    {:conditions => ['date >= ? and date <= ?', Date.parse(from), Date.parse(to)]} }
end