require 'stocko/service/common'

module Stocko
  module Service
    class StockoService
      include ChangeFilter
      include DateFilter
      
      attr :last_value

      def stock stock=Stocko::Service::NOT_SET
        return @stock if stock == Stocko::Service::NOT_SET
        @stock = if   stock.nil?
                 then nil
                 else Stock.find_by_name stock
                 end
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
  end
end