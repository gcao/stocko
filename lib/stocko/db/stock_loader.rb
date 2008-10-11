module Stocko
  module Db
    class StockLoader
      def self.load_from_file file, market, options = {:skip_lines => 0}
        stock_name = nil
        line_no = 0
        IO.foreach(file) do |line|
          line_no += 1
          next if options[:skip_lines] >= line_no
          row = line.split ','
          stock_name = row[0]
        end
        stock_desc_file = file.sub '.csv', '.txt'
        if File.exists? stock_desc_file
          stock_desc = read_description stock_desc_file
        else
          stock_desc = File.basename(file, '.csv')
        end
        Stock.create!(:market => market, :name => stock_name, :description => stock_desc)
        StockPriceLoader.load_from_file(file, options)
      end
      
      private
      
      def self.read_description file
        IO.readlines(file).join.strip
      end
    end
  end
end