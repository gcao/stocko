class MarketData < ActiveRecord::Base
  set_table_name "market_data"
  
  belongs_to :market
end