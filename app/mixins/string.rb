module StringExtensions
  def commify
    s = self
    s = s.insert(-4, ',') if s.size > 3
    s = s.insert(-8, ',') if s.size > 7
    s
  end
  
  def line_count
    split("\n").size
  end
end

String.send :include, StringExtensions