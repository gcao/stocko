require File.dirname(__FILE__) + '/config'
require File.dirname(__FILE__) + '/base'
require File.dirname(__FILE__) + '/pageable'

module ReportThis
  class ArrayReport < Base
    include Pageable
    
    def header
      if @model.empty?
        "<Empty Array>\n"
      else
        @model[0].report(@config).header
      end
    end
  end
end
