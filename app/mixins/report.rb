module Report
  def report config = nil
    klass = if   self.class.report_class
            then self.class.report_class.to_s.constantize
            else Stocko::Report::Base
            end

    klass.new(self, config).to_s
  end
  
  module ClassMethods
    def report_class class_name = 'NOT SET'
      if class_name == 'NOT SET'
        if @report_class
          @report_class.to_s
        else 
          default_report_class = self.to_s + "Report"
          if default_report_class.to_class
            default_report_class
          else
            nil
          end
        end
      else
        @report_class = class_name
      end
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end