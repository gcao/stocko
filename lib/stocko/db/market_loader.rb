module Stocko
  module Db
    class MarketLoader
      def self.load_from_directory dir, options = {:skip_lines => 0}
        market_name = File.basename(dir)
        market = Market.create!(:name => market_name)
        market_data_file = File.join(dir, 'market.csv')
        MarketDataLoader.load_from_file market_data_file, market, options
        (Dir["#{dir}/*.csv"] - ["#{dir}/market.csv"]).each do |f|
          StockLoader.load_from_file f, market, options
        end
      end
    end
  end
end