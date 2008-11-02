require 'net/http'
require 'nokogiri' 

module Stocko
  module Db
    module Yahoo
      class IndustryLoader
        def load_from_sector sector
          url = sector.attrs['yahoo_url']
          response = downloader.download url
          document = Nokogiri::HTML(response)
          td_xpath = "//table//table/tr[position()>3]/td[1]/a"
          document.xpath(td_xpath).each do |elem|
            name = elem.text.gsub("\n", "")
            yahoo_url = "http://biz.yahoo.com/p/" + elem.attributes['href']
            Industry.create!(:sector => sector, :name => name, :attrs => {'yahoo_url' => yahoo_url})
          end
        end
      end
    end
  end
end
