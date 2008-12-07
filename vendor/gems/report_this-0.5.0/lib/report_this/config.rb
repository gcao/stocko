module ReportThis
  class Config
    DEFAULT_OPTIONS = {
      :page_size => 20
    }

    def initialize options={}
      @options = DEFAULT_OPTIONS.clone
      options.each do |key, value|
        @options[key.to_sym] = value
      end
    end

    def [] key
      @options[key.to_sym]
    end

    def self.default
      @default ||= ReportThis::Config.new
    end
  end
end
