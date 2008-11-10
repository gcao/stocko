require 'factory_girl'

Factory.define :sector do |s|
  s.name 'Basic Materials'
  s.attrs 'yahoo_url' => Yahoo['sector_url'].call(1)
end

Factory.define :industry_gold do |i|
  i.name 'Gold'
  i.attrs 'yahoo_url' => Yahoo['industry_url'].call(134)
end