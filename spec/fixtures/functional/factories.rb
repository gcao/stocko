require 'factory_girl'

Factory.define :sector do |s|
  s.name "Basic Materials"
  s.attrs 'yahoo_url' => Yahoo['sector_url'].call(1)
end
