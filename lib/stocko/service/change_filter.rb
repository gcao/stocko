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
    end
  end
end
