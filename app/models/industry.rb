class Industry < ActiveRecord::Base
  belongs_to :sector
  
  serialize :attrs, Hash
end