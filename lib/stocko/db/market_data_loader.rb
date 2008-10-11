module Stocko
  module Db
    class MarketDataLoader
      def self.load_from_file file, market, options = {:skip_lines => 0}
        columns = [:market_id, :date, :volume, :high, :low, :open, :close]
        values = []

        skip_lines = options[:skip_lines]
        line_no = 0
        date = nil
        IO.foreach(file) do |line|
          line_no += 1
          next if skip_lines >= line_no
          row = line.split ','
          if row[1] == date
            next
          else
            date = row[1]
          end
          converted_date = date.clone
          converted_date.insert(6, '20') if converted_date =~ %r(^\d+/\d+/\d\d$)
          values << [market.id, converted_date, row[2], row[3], row[4], row[5], row[6]]
        end
        
        MarketData.import columns, values, :validate => false
      end
    end
  end
end