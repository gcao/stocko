class StockoService
  NOT_SET = "NOT SET"
  
  attr :last_value
  
  def stock stock=NOT_SET
    return @stock if stock == NOT_SET
    @stock = if   stock.nil?
             then nil
             else Stock.find_by_name stock
             end
  end
  
  def date from_date, to_date
    @from_date = Date.parse(from_date)
    @to_date   = Date.parse(to_date)
  end
  
  def from_date from_date=NOT_SET
    return @from_date if from_date == NOT_SET
    @from_date = Date.parse(from_date)
  end
  
  def to_date to_date=NOT_SET
    return @to_date if to_date == NOT_SET
    @to_date = Date.parse(to_date)
  end
  
  def prices
    if @stock.nil?
      return @last_value = nil
    end
    
    if @from_date.nil?
      if @to_date.nil?
        @last_value = StockPrice.stock(@stock)
      else
        @last_value = StockPrice.stock(@stock).before(@to_date)
      end
    else
      if @to_date.nil?
        @last_value = StockPrice.stock(@stock).after(@from_date)
      else
        @last_value = StockPrice.stock(@stock).between(@from_date, @to_date)
      end
    end
  end
end