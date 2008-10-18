class StockPrice < ActiveRecord::Base
  include Change
  
  belongs_to :stock
  
  named_scope :between, lambda{ |from, to|
    {:conditions => ['date >= ? and date <= ?', Date.parse(from), Date.parse(to)]} }
    
  named_scope :change_between, lambda{ |low, high|
    {:conditions => ['change >= ? and change <= ?', low, high]} }
    
  def next n=1
    if n == 1
      StockPrice.find(:first, :conditions => ["stock_id = ? and date > ?", stock.id, date])
    else
      StockPrice.find(:all, :conditions => ["stock_id = ? and date > ?", stock.id, date], :limit => n)
    end
  end
  
  def prev n=1
    if n == 1
      StockPrice.find(:first, :conditions => ["stock_id = ? and date < ?", stock.id, date],
        :order => "date desc")
    else
      StockPrice.find(:all, :conditions => ["stock_id = ? and date < ?", stock.id, date],
        :order => "date desc", :limit => n)
    end
  end
end