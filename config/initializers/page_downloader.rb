def downloader
  $downloader ||= Stocko::PageDownloader.new :cache_in_filesystem => true, :cache_dir => RAILS_ROOT + '/tmp/downloads'
end