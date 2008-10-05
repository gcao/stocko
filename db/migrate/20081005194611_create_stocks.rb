class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      t.integer :market_id, :null => false
      t.string :name, :limit => 255
      t.string :description, :limit => 4000
    end
    
    add_index :stocks, :name, :unique => true, :name => "stocks_name"
  end

  def self.down
    drop_table :stocks
  end
end
