module DateExtensions
  
  def next_date
    market_date.next.nil_or.date
  end
  
  def prev_date
    market_date.prev.nil_or.date
  end
  
  private
  
  def market_date
    unless @searched_in_db
      @market_date = MarketDate.find_by_date(self)
      raise "Stock market does not open on #{self}." if @market_date.nil?
      @searched_in_db = true
    end
    @market_date
  end
end

Date.send :include, DateExtensions
