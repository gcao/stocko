Yahoo = {
  # URL for browsing sectors
  'sectors_url' => "http://biz.yahoo.com/p/s_conameu.html",
  'sector_url' => lambda{|sector_index| "http://biz.yahoo.com/p/#{sector_index}conameu.html"},
  'industry_url' => lambda{|industry_index| "http://biz.yahoo.com/p/#{industry_index}conameu.html"},
}
