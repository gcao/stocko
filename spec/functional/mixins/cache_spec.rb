require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe RAILS_ROOT + '/app/mixins/cache.rb' do
  it "cache_key should return hashed value for object" do
    cache_key('abc').should eql(Digest::SHA1.hexdigest('abc'))
  end
  
  it "cache_get should return nil if not found" do
    cache_get('KEYNOTSET').should be_nil
  end
  
  it "cache_get should return cached value if found" do
    $cache.set(cache_key('key'), 'value')
    cache_get('key').should eql('value')
  end
  
  it "cache_set should set value in cache" do
    cache_set('key1', 'value')
    $cache.get(cache_key('key1')).should eql('value')
  end
end