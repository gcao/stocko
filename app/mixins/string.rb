module StringExtensions
  def commify
    s = self
    s = s.insert(-4, ',') if s.size > 3
    s = s.insert(-8, ',') if s.size > 7
    s = s.insert(-12, ',') if s.size > 11
    s
  end
  
  def line_count
    split("\n").size
  end
  
  def to_class
    file_path = self.pathize + ".rb"
    require file_path if File.exists? file_path
     
    split('::').inject(Kernel) {|scope, const_name| scope.const_get(const_name)}
  rescue
    nil
  end
end

String.send :include, StringExtensions