module Stocko
  module Report
    module Console
      class StockPriceReport < Stocko::Report::Base
        include CommonDailyReport
      end
    end
  end
end