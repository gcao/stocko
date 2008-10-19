module Stocko
  module Report
    module Console
      class MarketDataReport < Stocko::Report::Base
        include CommonDailyReport
      end
    end
  end
end