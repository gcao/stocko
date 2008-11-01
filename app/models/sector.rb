class Sector < ActiveRecord::Base
  has_many :industries
  
  serialize :attrs, Hash
end