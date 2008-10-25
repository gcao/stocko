module ObjectExtensions
  def nil_or
    return self unless self.nil?
    klass = Class.new do
      def method_missing(sym,*args); nil; end
    end
    klass.new
  end
end

Object.send(:include, ObjectExtensions)

Object.send(:include, Report)
