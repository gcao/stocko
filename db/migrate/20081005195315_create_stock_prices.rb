class CreateStockPrices < ActiveRecord::Migration
  def self.up
    create_table :stock_prices do |t|
      t.integer :stock_id, :null => false
      t.date :date, :null => false
      t.integer :open
      t.integer :close
      t.integer :high
      t.integer :low
    end
    
    add_index :stock_prices, [:stock_id, :date], :unique => true, :name => "stock_prices_stock_id_date"
  end

  def self.down
    drop_table :stock_prices
  end
end
