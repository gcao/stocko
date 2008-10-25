class ArrayReport < Stocko::Report::Base
  def header
    if @config[:colorize]
      StockPriceReport::COLORFUL_HEADER
    else
      StockPriceReport::HEADER
    end
  end

  def body
    unless @model.empty?
      @model[start_row - 1, rows].
      map{ |elem| StockPriceReport.new(elem, @config).body }.join
    end
  end

  def footer
    if @config[:colorize]
      "\033[36m" + default_footer.sub("\n", "\033[0m\n")
    else
      default_footer
    end
  end

  def page_number
    @page_number ||= (pages > 0 ? 1 : 0)
  end

  def pages
    @pages ||= 1 + (@model.size - 1) / @config[:page_size]
  end

  def next_page
    @page_number += 1 if page_number < pages
    self
  end
  alias next next_page

  def prev_page
    @page_number -= 1 if page_number > 1
    self
  end
  alias prev prev_page

  def goto_page page
    if page > pages
      @page_number = pages 
    elsif page > 0
      @page_number = page
    end
    self
  end
  alias goto goto_page

  private 

  # 1-based
  def start_row
    (page_number - 1) * @config[:page_size] + 1
  end

  # 1-based
  def end_row
    end_row = page_number * @config[:page_size]
    end_row = @model.size if @model.size < end_row
    end_row
  end

  def rows
    end_row - start_row + 1
  end

  def default_footer
    footer = "Page #{page_number}/#{pages}      "
    footer += "#{start_row} - #{end_row} of " unless @model.empty?
    footer += "#{@model.size} rows\n"
  end
end
