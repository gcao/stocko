excluded_gems = []
Dir["#{RAILS_ROOT}/vendor/gems/*"].each do |path|
  gem_name = File.basename(path.gsub(/-[.0-9]+$/, ''))
  $:.unshift path + "/lib/"

  unless excluded_gems.include? gem_name
    gem_path = path + "/lib/" + gem_name + ".rb"
    require gem_path if File.exists? gem_path
  end
end