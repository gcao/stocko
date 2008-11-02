require File.expand_path(File.dirname(__FILE__) + '/../functional_spec_helper')

describe Stocko::PageDownloader do
  describe "default config" do

    before :each do
      @downloader = Stocko::PageDownloader.new
    end

    it "should return page of the given url" do
      page = @downloader.download("http://www.google.com")
      page.should include('About Google')
    end

    it "should load from cache on consecutive download request" do
      url = "http://www.google.com"
      @downloader.download(url)
      dont_allow(Net::HTTP).get
      @downloader.download(url)
    end
  end
  
  it "cache in file system - bad configuration" do
    begin
      Stocko::PageDownloader.new :cache_in_filesystem => true
      fail "If cache_in_filesystem is set to true, cache_dir should be set too."
    rescue ArgumentError
    end
  end

  describe "cache in file system" do
    before :each do
      @downloader = Stocko::PageDownloader.new :cache_in_filesystem => true, :cache_dir => '/tmp'
    end
    
    it "should save to a file" do
      url = "http://www.google.com"
      cache_set url, nil
      response = @downloader.download(url)
      response.should eql(File.read('/tmp/' + cache_key(url)))
    end
  end
end