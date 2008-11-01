class CreateIndustries < ActiveRecord::Migration
  def self.up
    create_table :industries do |t|
      t.integer :sector_id, :null => false
      t.string :name, :null => false, :limit => 255
      t.string :description, :limit => 4000
      t.string :attrs, :limit => 65536
    end
    
    add_index :industries, :name, :unique => true, :name => "industries_name"
    add_index :industries, :sector_id, :name => "industries_sector_id"
  end

  def self.down
    drop_table :industries
  end
end
