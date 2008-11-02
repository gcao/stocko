class CreateStockIndexes < ActiveRecord::Migration
  def self.up
    create_table :stock_indexes do |t|
      t.string :name, :null => false, :limit => 255
      t.string :description, :limit => 4000
      t.string :attrs, :limit => 65536
    end
    
    add_index :stock_indexes, :name, :unique => true, :name => "stock_indexes_name"

    StockIndex.create!(:name => "dowjones")
  end

  def self.down
    drop_table :stock_indexes
  end
end
