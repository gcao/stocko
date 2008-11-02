require 'net/http'

module Stocko
  class PageDownloader
    DEFAULT_CONFIG = {
      :cache_in_memory => true,
      :cache_in_filesystem => false,
      :cache_dir => nil,
      :ttl => 3600
    }.freeze
    
    def initialize config = {}
      raise ArgumentError.new("If cache_in_filesystem is set to true, cache_dir should be set too.") if 
        config[:cache_in_filesystem] and not config[:cache_dir]
        
      @config = DEFAULT_CONFIG.merge(config)
    end
  
    def download url
      return download_forcefully(url) unless cache_this?
      
      response = cache_get(url)
      return response unless response.nil?
      
      if cache_in_filesystem?
        file = cache_to_file(url)
        if File.exists?(file)
          response = File.read(file)
        else
          response = download_forcefully url
          File.open(file, 'w'){ |f| f.print(response) }
        end
      else
        response = download_forcefully url
      end

      cache_set(url, response)
    
      response
    end
    
    private
    
    def download_forcefully url
      Net::HTTP.get(URI.parse(url))
    end
    
    def cache_this?
      @config[:cache_in_memory] or @config[:cache_in_filesystem]
    end
    
    def cache_in_filesystem?
      @config[:cache_in_filesystem]
    end
    
    def found_in_filesystem? url
      file = cache_to_file url
      File.exists?(file)
    end
    
    def cache_to_file url
      @config[:cache_dir] + "/" + cache_key(url)
    end
  end
end