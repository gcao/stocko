class StockPrice < ActiveRecord::Base
  include Change
  include ModelWithDate
  include ModelWithChange
  
  belongs_to :stock
  
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