require 'stocko/service/common'

module Stocko
  module Service
    module ChangeFilter
      def change_gt change_gt=Stocko::Service::NOT_SET
        return @change_gt if change_gt == Stocko::Service::NOT_SET
        
        @change_gt = BigDecimal.new(change_gt.to_s)
      end

      def change_lt change_lt=Stocko::Service::NOT_SET
        return @change_lt if change_lt == Stocko::Service::NOT_SET
        
        @change_lt = BigDecimal.new(change_lt.to_s)
      end

      def change change_gt, change_lt
        @change_gt = BigDecimal.new(change_gt.to_s)
        @change_lt = BigDecimal.new(change_lt.to_s)
      end
      
      def filter_by_change source
        if @change_gt.nil? and @change_lt.nil?
          source
        elsif @change_gt.nil?
          source.change_gt(@change_gt)
        elsif @change_lt.nil?
          source.change_lt(@change_lt)
        else
          source.change(@change_gt, @change_lt)
        end
      end
    end
  end
end
