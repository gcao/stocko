module Stocko
  module Report
    class Base
      def initialize model, config = Stocko::Report::Config.new
        @model = model
        @config = config
      end
      
      def header
      end
      
      def body
      end
      
      def footer
      end
    end
  end
end