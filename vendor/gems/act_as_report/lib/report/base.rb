module Report
  class Base
    attr_reader :model, :config

    def initialize model, config = nil
      @model = model
      @config = if   config.nil?
        then Report::Config.default
      else config 
      end
    end

    def header
      "<#{@model.class}>\n"
    end

    def body
      return "nil\n" if @model.nil?
      @model.to_s + "\n"
    end

    def footer
    end

    def to_s
      "#{header}#{body}#{footer}"
    end
  end
end