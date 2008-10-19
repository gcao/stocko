module Stocko
  module Report
    module Console
      class StockPriceReport < Stocko::Report::Base
        def initialize model, config = Stocko::Report::Config.new
          @model = model
          @config = config
        end

        def header
          if colorize?
            "\033[34m1 Date        2 Volume  3 Open 4 Close  5 High   6 Low   7 Change  8 MAX Chg\033[0m\n"
          else
            "1 Date        2 Volume  3 Open 4 Close  5 High   6 Low   7 Change  8 MAX Chg\n"
          end
        end

        def body
          if colorize?
            if @model.change >= 0.01
              "\033[31m" + default_body.sub("\n", "\033[0m\n")
            elsif @model.change <= -0.01
              "\033[32m" + default_body.sub("\n", "\033[0m\n")
            else
              "\033[37m" + default_body.sub("\n", "\033[0m\n")
            end
          else
            default_body
          end
        end

        private
        
        def default_body
          sprintf("#{@model.date}  %10s  %6.2f  %6.2f  %6.2f  %6.2f  %8.2f%%  %8.2f%%\n", 
            @model.volume.to_s.commify, @model.open, @model.close, @model.high, @model.low, @model.change * 100, @model.max_change * 100)
        end

        def colorize?
          @config[:colorize]
        end

      end
    end
  end
end