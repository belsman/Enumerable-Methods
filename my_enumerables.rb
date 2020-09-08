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

  def my_none?
    !my_any? { |el| yield(el) }
  end

  def my_count(item = nil)
    return my_select { |el| el == item }.size if item

    return my_select { |el| yield(el) }.size if block_given?

    size
  end

  def my_map
    return enum_for(__method__) unless block_given?

    result = []
    my_each_with_index { |_, idx| result << el if yield(el) }
    result
  end
end

a = [ "a", "b", "c", "d" ]
a.collect {|x| x + "!"}           #=> ["a!", "b!", "c!", "d!"]
a.map.with_index {|x, i| x * i}   #=> ["", "b", "cc", "ddd"]
a                                 #=> ["a", "b", "c", "d"]
