module Change
  def up?
    close > open
  end
  
  def down?
    close < open
  end
  
  def change
    (close - open) / open
  end
  
  def max_change
    (high - low) / open
  end
end