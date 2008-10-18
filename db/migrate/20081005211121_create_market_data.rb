class CreateMarketData < ActiveRecord::Migration
  def self.up
    create_table :market_data do |t|
      t.integer :market_id, :null => false
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
    
    add_index :market_data, [:market_id, :date], :unique => true, :name => "market_data_market_id_date"
    add_index :market_data, :volume, :name => "market_data_volume"
    add_index :market_data, :open, :name => "market_data_open"
    add_index :market_data, :close, :name => "market_data_close"
    add_index :market_data, :change, :name => "market_data_change"
    add_index :market_data, :max_change, :name => "market_data_max_change"
  end

  def self.down
    drop_table :market_data
  end
end
