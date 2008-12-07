
module ReportThis
  module Pageable
    
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
  end
end