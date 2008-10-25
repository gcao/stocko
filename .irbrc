# add below lines to ~/.irbrc
#
# begin
#   require 'rubygems'
#   require 'wirble'
#   Wirble.init
#   Wirble.colorize
# rescue LoadError
#   puts "Error loading Wirble. Run 'sudo gem install wirble' to enable colorized results."
# end
#
#load ".irbrc" if File.exists? ".irbrc"

require 'yaml'

class IRB::Irb
  def output_value
    last_value = @context.last_value

    if not last_value.nil? 
      if last_value.respond_to? :report
        print last_value.report
      else @context.inspect?
        print last_value.to_yaml
      end
    else
      printf @context.return_format, last_value
    end
  end
end