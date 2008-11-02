class IndexPrice < ActiveRecord::Base
  include Change
  include ModelWithDate
  include ModelWithChange
  
  belongs_to :stock_index
  
  named_scope :stock_index, lambda{ |index|
    {:conditions => ['stock_index_id = ?', stock_index.id]} 
  }
  
  def next n=1
    if n == 1
      self.class.find(:first, :conditions => ["stock_index_id = ? and date > ?", stock_index.id, date])
    else
      self.class.find(:all, :conditions => ["stock_index_id = ? and date > ?", stock_index.id, date], :limit => n)
    end
  end
  
  def prev n=1
    if n == 1
      self.class.find(:first, :conditions => ["stock_index_id = ? and date < ?", stock_index.id, date],
        :order => "date desc")
    else
      self.class.find(:all, :conditions => ["stock_index_id = ? and date < ?", stock_index.id, date],
        :order => "date desc", :limit => n)
    end
  end
end