module Stocko
  module Db
    class MarketDateLoader
      def append date
        d = Date.parse(date)
        new_date = MarketDate.new(:date => d, :year => d.year, :month => d.month, 
                                  :first_of_month => true, :last_of_month => true)
                                     
        if @last_saved_date
          new_date.prev = @last_saved_date
          @last_saved_date.next = new_date
          if new_date.year == @last_saved_date.year and new_date.month == @last_saved_date.month
            @last_saved_date.last_of_month = false
            new_date.first_of_month = false
          end
          @last_saved_date.save!
        end
        
        new_date.save!
        
        @last_saved_date = new_date
      end
    end
  end
end
