module ModelWithChange
  def self.included(receiver)
    receiver.named_scope :change_between, lambda{ |low, high|
      {:conditions => ['change >= ? and change <= ?', low, high]} 
    }
  end
end