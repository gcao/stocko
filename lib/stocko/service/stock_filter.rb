require 'stocko/service/common'

module Stocko
  module Service
    module StockFilter
      def stock stock=Stocko::Service::NOT_SET
        return @stock if stock == Stocko::Service::NOT_SET
        
        @stock = if   stock.nil?
                 then nil
                 else Stock.find_by_name stock
                 end
      end
      
      def filter_by_stock source
        if @stock.nil?
          source
        else
          source.stock(@stock)
        end
      end
    end
  end
end