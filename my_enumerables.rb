module Enumerable
  def my_each
    return enum_for(__method__) unless block_given?

    arr = to_a
    size.times { |idx| yield(arr[idx]) }
    self
  end
  
  def my_each_with_index
    return enum_for(__method__) unless block_given?

    arr = to_a
    size.times { |idx| yield(arr[idx], idx) }
    self
  end

  def my_select
    return enum_for(__method__) unless block_given?

    result = []
    my_each { |el| result << el if yield(el) }
    result
  end

  def my_all?
    my_each do |el|
      if block_given?
        return false unless yield(el)
      else
        return false unless el
      end
    end
    true
  end

  def my_any?
    my_each do |el|
      if block_given?
        return true if yield(el)
      else
        return true if el
      end
    end
    false
  end
end


#p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
#p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].any?                    #=> false
#p [nil, true, 99].my_any?                    #=> true
#p [nil, true, 99].my_any?                              #=> true
#p [].my_any?                                           #=> false