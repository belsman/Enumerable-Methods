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

  def my_all
    return enum_for(__method__) unless block_given?

    arr = to_a
    arr.my_each do |el|
        if yield(el) === el
          return true
        end
    end
  end
end

puts %w[ant bear cat].my_all { |word| word.length >= 3 } #=> true
%w[ant bear cat].all? { |word| word.length >= 4 } #=> false
