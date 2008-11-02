module Stocko
  module Db
    class IndexLoader
      def self.load_from_file file, options = {:skip_lines => 0}
        index_name = File.basename(file)
        index = Index.create!(:name => index_name)
        index_prices_file = File.join(dir, 'dowjones.csv')
        IndexPriceLoader.load_from_file index_prices_file, index, options
        (Dir["#{dir}/*.csv"] - ["#{dir}/market.csv"]).each do |f|
          StockLoader.load_from_file f, market, options
        end
      end
    end
  end
end