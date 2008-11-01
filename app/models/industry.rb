class Industry < ActiveRecord::Base
  belong_to :sector
  
  serialize :attrs, Hash
end