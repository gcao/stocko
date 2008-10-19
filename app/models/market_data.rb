class MarketData < ActiveRecord::Base
  include Change
  include ModelWithDate
  include ModelWithChange
  
  set_table_name "market_data"
  
  belongs_to :market
  
  def next n=1
    if n == 1
      MarketData.find(:first, :conditions => ["market_id = ? and date > ?", market.id, date])
    else
      MarketData.find(:all, :conditions => ["market_id = ? and date > ?", market.id, date], :limit => n)
    end
  end
  
  def prev n=1
    if n == 1
      MarketData.find(:first, :conditions => ["market_id = ? and date < ?", market.id, date],
        :order => "date desc")
    else
      MarketData.find(:all, :conditions => ["market_id = ? and date < ?", market.id, date],
        :order => "date desc", :limit => n)
    end
  end
  
  def to_s
    sprintf("#{date}  %11s  %8.2f  %8.2f  %8.2f  %8.2f  %8.2f%%  %8.2f%%\n", volume.to_s.commify, open, close, high, low, change*100, max_change*100)
  end
  
  def self.report_header
    "1 Date         2 Volume    3 Open   4 Close    5 High     6 Low   7 Change  8 MAX Chg\n"
  end
end