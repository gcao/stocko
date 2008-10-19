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
  
  def to_s
    sprintf("#{date}  %10s  %6.2f  %6.2f  %6.2f  %6.2f  %8.2f%%  %8.2f%%\n", volume.to_s.commify, open, close, high, low, change*100, max_change*100)
  end
  
  def self.report_header
    "1 Date        2 Volume  3 Open 4 Close  5 High   6 Low   7 Change  8 MAX Chg\n"
  end
  
  def colorful_report
    if change >= 0.01
      "\033[31m" + to_s.sub("\n", "\033[0m\n")
    elsif change <= -0.01
      "\033[32m" + to_s.sub("\n", "\033[0m\n")
    else
      "\033[37m" + to_s.sub("\n", "\033[0m\n")
    end
  end

  def self.colorful_report_header
    "\033[34m1 Date        2 Volume  3 Open 4 Close  5 High   6 Low   7 Change  8 MAX Chg\033[0m\n"
  end
end