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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def my_all?(pattarn_or_cls = nil)
    my_each do |el|
      if pattarn_or_cls
        return false if pattarn_or_cls.is_a?(Regexp) && el !~ pattarn_or_cls

        begin
          return false if !pattarn_or_cls.is_a?(Regexp) && pattarn_or_cls.is_a?(Object) && !el.is_a?(pattarn_or_cls)
        rescue TypeError
          return false unless el == pattarn_or_cls
        end

      elsif block_given?
        return false unless yield(el)
      else
        return false unless el
      end
    end
    true
  end

  def my_any?(pattarn_or_cls = nil)
    my_each do |el|
      if pattarn_or_cls
        return true if pattarn_or_cls.is_a?(Regexp) && el =~ pattarn_or_cls

        begin
          return true if !pattarn_or_cls.is_a?(Regexp) && pattarn_or_cls.is_a?(Object) && el.is_a?(pattarn_or_cls)
        rescue TypeError
          return true if el == pattarn_or_cls
        end
      elsif block_given?
        return true if yield(el)
      elsif el
        return true
      end
    end
    false
  end

  def my_none?(pattarn_or_cls = nil)
    if !block_given?
      !my_any?(pattarn_or_cls) { |el| el }
    else
      !my_any?(pattarn_or_cls) { |el| yield(el) }
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def my_inject(memo = nil, sym = nil)
    result = to_a[0]
    operator = nil

    operations = {
      :+ => proc { |accumulator, n| accumulator + n },
      :* => proc { |accumulator, n| accumulator * n },
      :/ => proc { |accumulator, n| accumulator / n },
      :- => proc { |accumulator, n| accumulator - n }
    }

    if memo && sym
      result = memo
      operator = sym
    elsif memo && !sym && !block_given?
      operator = memo
    elsif memo && block_given?
      result = memo
    end

    my_each { |el| result = operator ? operations[operator].call(result, el) : yield(result, el) }

    result
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end

def multiply_els(arr)
  arr.my_inject(1) { |product, n| product * n }
end
