class MarketDate < ActiveRecord::Base
  has_one :prev, :class_name => 'MarketDate', :foreign_key => 'prev_id'
  has_one :next, :class_name => 'MarketDate', :foreign_key => 'next_id'
end