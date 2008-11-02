class CreateIndexPrices < ActiveRecord::Migration
  def self.up
    create_table :index_prices do |t|
      t.integer :stock_index_id, :null => false
      t.date :date, :null => false
      t.integer :volume
      t.decimal :open, :precision => 10, :scale => 4
      t.decimal :close, :precision => 10, :scale => 4
      t.decimal :high, :precision => 10, :scale => 4
      t.decimal :low, :precision => 10, :scale => 4
      t.decimal :change, :precision => 8, :scale => 4
      t.decimal :max_change, :precision => 8, :scale => 4
      t.decimal :prev_close, :precision => 10, :scale => 4
    end
    
    add_index :index_prices, [:stock_index_id, :date], :unique => true, :name => "index_prices_stock_index_id_date"
    add_index :index_prices, :volume, :name => "index_prices_volume"
    add_index :index_prices, :open, :name => "index_prices_open"
    add_index :index_prices, :close, :name => "index_prices_close"
    add_index :index_prices, :change, :name => "index_prices_change"
    add_index :index_prices, :max_change, :name => "index_prices_max_change"
  end

  def self.down
    drop_table :index_prices
  end
end
