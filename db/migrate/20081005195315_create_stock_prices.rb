class CreateStockPrices < ActiveRecord::Migration
  def self.up
    create_table :stock_prices do |t|
      t.integer :stock_id, :null => false
      t.date :date, :null => false
      t.integer :volume
      t.decimal :open, :precision => 8, :scale => 4
      t.decimal :close, :precision => 8, :scale => 4
      t.decimal :high, :precision => 8, :scale => 4
      t.decimal :low, :precision => 8, :scale => 4
    end
    
    add_index :stock_prices, [:stock_id, :date], :unique => true, :name => "stock_prices_stock_id_date"
  end

  def self.down
    drop_table :stock_prices
  end
end
