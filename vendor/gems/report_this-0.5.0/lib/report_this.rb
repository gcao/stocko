module ReportThis
  module InstanceMethods
    def report config = nil
      klass = self.class.report_class ? 
              self.class.report_class.to_s.constantize : Stocko::Report::Base

      klass.new(self, config)
    end
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
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end
end

Object.send(:include, ReportThis)