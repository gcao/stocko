class StockPrice < ActiveRecord::Base
  belongs_to :stock
  
  named_scope :between, lambda{ |from, to|
    {:conditions => ['date > ? and date < ?', from, to]} }
end