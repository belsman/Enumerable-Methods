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

    for el in self
      boolean_value = yield(el) # true or false
      result << el if boolean_value
    end
    result 
  end
end


p (1..10).my_select { |i|  i % 3 == 0 }   #=> [3, 6, 9]

p [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

p [:foo, :bar].my_select #{ |x| x == :foo }   #=> [:foo]
