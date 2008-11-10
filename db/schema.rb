# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081005195315) do

  create_table "index_prices", :force => true do |t|
    t.integer "stock_index_id",                                :null => false
    t.date    "date",                                          :null => false
    t.integer "volume"
    t.decimal "open",           :precision => 10, :scale => 4
    t.decimal "close",          :precision => 10, :scale => 4
    t.decimal "high",           :precision => 10, :scale => 4
    t.decimal "low",            :precision => 10, :scale => 4
    t.decimal "change",         :precision => 8,  :scale => 4
    t.decimal "max_change",     :precision => 8,  :scale => 4
    t.decimal "prev_close",     :precision => 10, :scale => 4
  end

  add_index "index_prices", ["change"], :name => "index_prices_change"
  add_index "index_prices", ["close"], :name => "index_prices_close"
  add_index "index_prices", ["max_change"], :name => "index_prices_max_change"
  add_index "index_prices", ["open"], :name => "index_prices_open"
  add_index "index_prices", ["date", "stock_index_id"], :name => "index_prices_stock_index_id_date", :unique => true
  add_index "index_prices", ["volume"], :name => "index_prices_volume"

  create_table "industries", :force => true do |t|
    t.integer "sector_id",                    :null => false
    t.string  "name",                         :null => false
    t.string  "description", :limit => 4000
    t.string  "attrs",       :limit => 65536
  end

  add_index "industries", ["name"], :name => "industries_name", :unique => true
  add_index "industries", ["sector_id"], :name => "industries_sector_id"

  create_table "market_dates", :force => true do |t|
    t.date    "date",           :null => false
    t.integer "prev_id"
    t.integer "next_id"
    t.integer "year"
    t.integer "month"
    t.boolean "first_of_month"
    t.boolean "last_of_month"
  end

  add_index "market_dates", ["date"], :name => "market_dates_date", :unique => true
  add_index "market_dates", ["month"], :name => "market_dates_month"
  add_index "market_dates", ["year"], :name => "market_dates_year"

  create_table "markets", :force => true do |t|
    t.string "name"
    t.string "description", :limit => 4000
  end

  add_index "markets", ["name"], :name => "markets_name", :unique => true

  create_table "sectors", :force => true do |t|
    t.string "name",                         :null => false
    t.string "description", :limit => 4000
    t.string "attrs",       :limit => 65536
  end

  add_index "sectors", ["name"], :name => "sectors_name", :unique => true

  create_table "stock_indexes", :force => true do |t|
    t.string "name",                         :null => false
    t.string "description", :limit => 4000
    t.string "attrs",       :limit => 65536
  end

  add_index "stock_indexes", ["name"], :name => "stock_indexes_name", :unique => true

  create_table "stock_prices", :force => true do |t|
    t.integer "stock_id",                                 :null => false
    t.date    "date",                                     :null => false
    t.integer "volume"
    t.decimal "open",       :precision => 8, :scale => 4
    t.decimal "close",      :precision => 8, :scale => 4
    t.decimal "high",       :precision => 8, :scale => 4
    t.decimal "low",        :precision => 8, :scale => 4
    t.decimal "change",     :precision => 6, :scale => 4
    t.decimal "max_change", :precision => 6, :scale => 4
    t.decimal "prev_close", :precision => 8, :scale => 4
  end

  add_index "stock_prices", ["change"], :name => "stock_prices_change"
  add_index "stock_prices", ["high"], :name => "stock_prices_high"
  add_index "stock_prices", ["low"], :name => "stock_prices_low"
  add_index "stock_prices", ["max_change"], :name => "stock_prices_max_change"
  add_index "stock_prices", ["date", "stock_id"], :name => "stock_prices_stock_id_date", :unique => true
  add_index "stock_prices", ["volume"], :name => "stock_prices_volume"

  create_table "stocks", :force => true do |t|
    t.string "name"
    t.string "description", :limit => 4000
  end

  add_index "stocks", ["name"], :name => "stocks_name", :unique => true

end
