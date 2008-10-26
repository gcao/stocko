module ModelWithDate
  def self.included(receiver)
    receiver.named_scope :between, lambda{ |from, to|
      from = Date.parse(from) if from.is_a? String
      to = Date.parse(to) if to.is_a? String
      {:conditions => ['date >= ? and date <= ?', from, to]} 
    }
    
    receiver.named_scope :after, lambda{ |from|
      from = Date.parse(from) if from.is_a? String
      {:conditions => ['date >= ?', from]} 
    }
    
    receiver.named_scope :before, lambda{ |to|
      to = Date.parse(to) if to.is_a? String
      {:conditions => ['date <= ?', to]} 
    }
  end
end