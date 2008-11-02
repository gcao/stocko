class StockIndex < ActiveRecord::Base
  has_many :stocks
  has_many :prices, :class_name => "IndexPrice", :dependent => :destroy
  
  set_table_name "stock_indexes"
  
  validates_presence_of :name
  
  def to_s
    name
  end
  
  def self.method_missing name, *args
    return super if name.to_s[0..3] == 'find'
      
    if stock_index = find_by_name(name.to_s)
      define_method name do
        stock_index
      end
      stock_index
    else
      super
    end
  end
end