class Stock < ActiveRecord::Base
  belongs_to :market
  has_many :prices, :class_name => "StockPrice", :dependent => :destroy
  
  validates_format_of :name, :with => /^[a-z]+$/
  
  def to_s
    name
  end
  
  def self.method_missing name, *args
    return super if name.to_s[0..3] == 'find'
      
    if stock = find_by_name(name.to_s)
      define_method name do
        stock 
      end
      stock
    else
      super
    end
  end
end
