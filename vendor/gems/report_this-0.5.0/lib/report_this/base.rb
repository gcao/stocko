require File.dirname(__FILE__) + '/config'

module ReportThis
  class Base
    attr_reader :model, :config

    def initialize model, config = nil
      @model = model
      @config = config.nil? ? ReportThis::Config.default : config
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