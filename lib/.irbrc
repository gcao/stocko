begin
  require 'rubygems'
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
  puts "Error loading Wirble. Run 'sudo gem install wirble' to enable colorized results."
end

require 'yaml'

class IRB::Irb
  def output_value
    if @context.inspect?
      printf @context.return_format, @context.last_value.to_yaml
    else
      printf @context.return_format, @context.last_value
    end
  end
end
