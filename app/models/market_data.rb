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
end