module ModelWithChange
  def self.included(receiver)
    receiver.named_scope :change_between, lambda{ |low, high|
      {:conditions => ['change >= ? and change <= ?', low, high]} 
    }
    
    receiver.named_scope :change_gt, lambda{ |low|
      {:conditions => ['change >= ?', low]} 
    }
    
    receiver.named_scope :change_lt, lambda{ |high|
      {:conditions => ['change <= ?', high]} 
    }
  end
end