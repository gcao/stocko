module Stocko
  module Db
    class MarketDataLoader
      def self.load_from_file file, market, options = {:skip_lines => 0}
        columns = [:market_id, :date, :volume, :high, :low, :open, :close, :change, :max_change, :prev_close]
        values = []
        
        date_loader = MarketDateLoader.new

        skip_lines = options[:skip_lines]
        line_no = 0
        date = nil
        prev_close = nil
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
          volume = row[2]
          high = row[3].to_f
          low = row[4].to_f
          open = row[5].to_f
          close = row[6].to_f
          change = close/open - 1
          max_change = (high - low)/open
          prev_close = open if prev_close.nil?
          
          values << [market.id, converted_date, volume, high, low, open, close, change, max_change, prev_close]
          date_loader.append(converted_date)
          
          prev_close = close
        end
        
        MarketData.import columns, values, :validate => false
      end
    end
  end
end