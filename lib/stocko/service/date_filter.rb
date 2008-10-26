require 'stocko/service/common'

module Stocko
  module Service
    module DateFilter
      def date from_date, to_date
        @from_date = Date.parse(from_date)
        @to_date   = Date.parse(to_date)
      end

      def from_date from_date=NOT_SET
        return @from_date if from_date == NOT_SET
        @from_date = Date.parse(from_date)
      end

      def to_date to_date=NOT_SET
        return @to_date if to_date == NOT_SET
        @to_date = Date.parse(to_date)
      end
    end
  end
end