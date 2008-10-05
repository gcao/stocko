class CreateMarkets < ActiveRecord::Migration
  def self.up
    create_table :markets do |t|
      t.string :name, :limit => 255
      t.string :description, :limit => 4000
    end
    
    add_index :markets, :name, :unique => true, :name => "markets_name"
  end

  def self.down
    drop_table :markets
  end
end
