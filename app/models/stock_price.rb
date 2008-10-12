class StockPrice < ActiveRecord::Base
  include Change
  
  belongs_to :stock
  
  named_scope :between, lambda{ |from, to|
    {:conditions => ['date >= ? and date <= ?', Date.parse(from), Date.parse(to)]} }
end