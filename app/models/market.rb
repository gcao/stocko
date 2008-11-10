class Market < ActiveRecord::Base
  validates_format_of :name, :with => /^[a-z]+$/
end