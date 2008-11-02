module Cache
  def cache_key raw_key
    Digest::SHA1.hexdigest(raw_key.to_s)
  end
  
  def cache_get raw_key
    key = cache_key raw_key
    begin
      value = $cache.get key
    rescue Memcached::NotFound
      value = nil
    end
  end
  
  def cache_set raw_key, value
    key = cache_key raw_key
    $cache.set key, value
  end
end

Object.send :include, Cache