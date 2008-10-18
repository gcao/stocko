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
      t.decimal :change, :precision => 4, :scale => 4
      t.decimal :max_change, :precision => 4, :scale => 4
    end
    
    add_index :stock_prices, [:stock_id, :date], :unique => true, :name => "stock_prices_stock_id_date"
    add_index :stock_prices, [:high], :name => "stock_prices_high"
    add_index :stock_prices, [:low], :name => "stock_prices_low"
    add_index :stock_prices, [:change], :name => "stock_prices_change"
    add_index :stock_prices, [:max_change], :name => "stock_prices_max_change"
  end

  def self.down
    drop_table :stock_prices
  end
end
