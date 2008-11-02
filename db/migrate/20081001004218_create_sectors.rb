class CreateSectors < ActiveRecord::Migration
  def self.up
    create_table :sectors do |t|
      t.string :name, :null => false, :limit => 255
      t.string :description, :limit => 4000
      t.string :attrs, :limit => 65536
    end
    
    add_index :sectors, :name, :unique => true, :name => "sectors_name"

    attrs = lambda{|index| {'yahoo_url' => Yahoo['sector_url'].call(index)} }
    
    Sector.create!(:name => "Basic Materials", :attrs => attrs.call(1))
    Sector.create!(:name => "Conglomerates", :attrs => attrs.call(2))
    Sector.create!(:name => "Consumer Goods", :attrs => attrs.call(3))
    Sector.create!(:name => "Financial", :attrs => attrs.call(4))
    Sector.create!(:name => "Healthcare", :attrs => attrs.call(5))
    Sector.create!(:name => "Industrial Goods", :attrs => attrs.call(6))
    Sector.create!(:name => "Services", :attrs => attrs.call(7))
    Sector.create!(:name => "Technology", :attrs => attrs.call(8))
    Sector.create!(:name => "Utilities", :attrs => attrs.call(9))
  end

  def self.down
    drop_table :sectors
  end
end
