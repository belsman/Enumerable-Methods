module Enumerable
  def my_each
    return enum_for(__method__) unless block_given?
    
    size.times { |idx| yield(to_a[idx]) }
    self
  end
end
