module Stocko
  module Db
    class PriceLoader
      def self.load_from_file model, parent_model, file, options = {:skip_lines => 0}
        foreign_key_column = (parent_model.class.name.downcase + "_id").to_sym
        columns = [foreign_key_column, :date, :volume, :high, :low, :open, :close, :change, :max_change, :prev_close]
        values = []

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
          
          values << [parent_model.id, converted_date, volume, high, low, open, close, change, max_change, prev_close]
          
          prev_close = close
        end
        
        model.import columns, values, :validate => false
      end
    end
  end
end