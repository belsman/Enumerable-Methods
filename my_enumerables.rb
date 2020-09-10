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

  def my_all?(pattarn_or_cls=nil)
    if pattarn_or_cls
      my_each do |el|
        if pattarn_or_cls.is_a?(Regexp)
          return false unless el =~ pattarn_or_cls
        elsif pattarn_or_cls.is_a?(Object)
          return false unless el.is_a?(pattarn_or_cls)
        end
      end 
    else
      my_each do |el|
        if block_given?
          return false unless yield(el)
        else
          return false unless el
        end
      end
    end
    true
  end

  def my_any?(pattarn_or_cls=nil)
    if pattarn_or_cls
      my_each do |el|
        if pattarn_or_cls.is_a?(Regexp)
          return true if el =~ pattarn_or_cls
        elsif pattarn_or_cls.is_a?(Object)
          return true if el.is_a?(pattarn_or_cls)
        end
      end 
    else
      my_each do |el|
        if block_given?
          return true if yield(el)
        elsif el
          return true
        end
      end
    end
    false
  end

  def my_none?(pattarn_or_cls=nil)
    unless block_given?
      !my_any?(pattarn_or_cls) { |el| el }
    else
      !my_any?(pattarn_or_cls) { |el| yield(el) }
    end
  end

  def my_count(item = nil)
    return my_select { |el| el == item }.size if item

    return my_select { |el| yield(el) }.size if block_given?

    size
  end

  def my_map(maping_proc = nil)
    return enum_for(__method__) if maping_proc.nil? && !block_given?

    result = []
    my_each_with_index do |el, idx|
      result[idx] = !maping_proc.nil? ? maping_proc.call(el, idx) : yield(el, idx)
    end
    result
  end

  def my_inject(memo = 0)
    return enum_for(__method__) unless block_given?

    result = memo
    my_each { |el| result = yield(result, el) }
    result
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |product, n| product * n }
end

p %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
p %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
p %w{ant bear cat}.my_none?(/d/)                        #=> true
p [1, 3.14, 42].my_none?(Float)                         #=> false
p [].my_none?                                           #=> true
p [nil].my_none?                                        #=> true
p [nil, false].my_none?                                 #=> true
p [nil, false, true].my_none?                           #=> false