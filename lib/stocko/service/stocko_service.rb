require 'stocko/service/common'

module Stocko
  module Service
    class StockoService
      include StockFilter
      include ChangeFilter
      include DateFilter
      
      def market
        @market ||= Market.first
      end

      def prices
        source = filter_by_stock StockPrice
        source = filter_by_date source
        source = filter_by_change source
      end
    end
  end
end