module ArrayExtensions
  include Change
  
  attr_writer :grouped
    
  def array_of_array?
    empty? or first.is_a? Array
  end

  def array_of_stocks?
    empty? or first.is_a? Stock
  end

  def array_of_market_data?
    empty? or first.is_a? MarketData
  end

  def array_of_stock_prices?
    empty? or first.is_a? StockPrice
  end

  def volume
    if array_of_market_data_or_stock_prices?
      sum = inject( nil ) { |sum,x| sum ? sum + x.volume : x.volume }
      (sum / size).to_i
    else
      raise NotImplementedError, "volume is not implemented on array of #{first.class}"
    end
  end

  def open
    if array_of_market_data_or_stock_prices?
      first.open
    else
      raise NotImplementedError, "open is not implemented on array of #{first.class}"
    end
  end

  def close
    if array_of_market_data_or_stock_prices?
      last.close
    else
      raise NotImplementedError, "close is not implemented on array of #{first.class}"
    end
  end

  def high
    if array_of_market_data_or_stock_prices?
      inject(0) { |high, x| high > x.high ? high : x.high }
    else
      raise NotImplementedError, "high is not implemented on array of #{first.class}"
    end
  end

  def low
    if array_of_market_data_or_stock_prices?
      inject(nil) { |low, x| low && low < x.low ? low : x.low }
    else
      raise NotImplementedError, "low is not implemented on array of #{first.class}"
    end
  end

  def start_date
    if array_of_market_data_or_stock_prices?
      first.date
    else
      raise NotImplementedError, "start_date is not implemented on array of #{first.class}"
    end
  end

  def end_date
    if array_of_market_data_or_stock_prices?
      last.date
    else
      raise NotImplementedError, "end_date is not implemented on array of #{first.class}"
    end
  end
  
  def group_by_date
    return self if grouped?
    
    if empty? or size == 1
      grouped = true
      return self
    end
    
    result = []
    result.grouped = true
    
    last_group = []
    last_group.grouped = true
    last_elem = nil
    each do |elem|
      if last_elem
        if last_elem.date.next_date == elem.date
          last_group << elem
        else
          result << last_group
          last_group = [elem]
          last_group.grouped = true
        end
      else
        last_group << elem
      end

      last_elem = elem
    end
    
    result << last_group unless last_group.empty?
    
    return result[0] if result.size == 1
    result
  end
  
  def grouped?
    @grouped
  end

  private

  def array_of_market_data_or_stock_prices?
    empty? or first.is_a? MarketData or first.is_a? StockPrice
  end

end

Array.send :include, ArrayExtensions
