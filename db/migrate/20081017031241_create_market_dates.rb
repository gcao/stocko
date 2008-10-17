class CreateMarketDates < ActiveRecord::Migration
  def self.up
    create_table :market_dates do |t|
      t.date :date, :null => false
      t.integer :prev_id
      t.integer :next_id
      t.integer :year
      t.integer :month
      t.boolean :first_of_month
      t.boolean :last_of_month
    end
    
    add_index :market_dates, :date, :unique => true, :name => "market_dates_date"
  end

  def self.down
    drop_table :market_dates
  end
end
