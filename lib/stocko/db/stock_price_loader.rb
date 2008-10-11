module Stocko
  module Db
    class StockPriceLoader
      def self.load_from_file file, options = {:skip_lines => 0}
        columns = [:stock_id, :date, :volume, :high, :low, :open, :close]
        values = []

        stock = nil
        
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
          stock = Stock.find_by_name row[0].downcase unless stock
          converted_date = date.clone
          converted_date.insert(6, '20') if converted_date =~ %r(^\d+/\d+/\d\d$)
          values << [stock.id, converted_date, row[2], row[3], row[4], row[5], row[6]]
        end
        
        StockPrice.import columns, values, :validate => false
      end
    end
  end
end