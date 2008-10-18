module Change
  def up?
    change > 0
  end
  
  def down?
    change < 0
  end
end