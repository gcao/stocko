require 'stocko/service/common'

module Stocko
  module Service
    class StockoService
      include ChangeFilter
      include DateFilter
      
      def market
        @market ||= Market.first
      end

      def stock stock=Stocko::Service::NOT_SET
        return @stock if stock == Stocko::Service::NOT_SET
        
        @stock = if   stock.nil?
                 then nil
                 else Stock.find_by_name stock
                 end
      end

      def prices
        source = StockPrice        
        
        source = source.stock(@stock) unless @stock.nil?

        
        
        
        
        source
      end
      
    end
  end
end