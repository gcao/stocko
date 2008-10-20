module Stocko
  module Report
    class Base
      attr_reader :model, :config
      
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
      
      def to_s
        "#{header}#{body}#{footer}"
      end
    end
  end
end