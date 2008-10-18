module ModelWithDate
  def self.included(receiver)
    receiver.named_scope :between, lambda{ |from, to|
      {:conditions => ['date >= ? and date <= ?', Date.parse(from), Date.parse(to)]} 
    }
  end
end