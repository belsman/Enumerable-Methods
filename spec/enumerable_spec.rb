require './my_enumerables'

describe Enumerable do
  let(:int_arry) { [1, 2, 3, 4, 5] }
  let(:string_arry) { %w[cat dog yam egg] }
  let(:false_arry) { [nil, false, nil] }
  let(:mix_arry) { [100, nil, false, 'bake', 'hen'] }
  let(:test_hash) { { a: 1, b: 2, c: 3 } }
  let(:result) { [] }

  let(:test_proc) { proc { |e| "value is #{e}" } }
  let(:test_proc2) { proc { |e| e**2 } }

  describe '#my_each' do
    it 'returns same array, unmodified when passed a block.' do
      result = int_arry.my_each { |e| e * 3 }
      expect(result).to equal(int_arry)
    end

    it 'returns same hash, unmodified when passed a block.' do
      result = test_hash.my_each { |_k, v| v * 2 }
      expect(result).to equal(test_hash)
    end

    it 'returns an <Enumerable> class. If no block is passed -- when caller is array.' do
      expect(int_arry.my_each).to be_an Enumerable
    end

    it 'returns an <Enumerable> class. If no block is passed -- when caller is hash.' do
      expect(test_hash.my_each).to be_an Enumerable
    end
  end

  describe '#my_each_with_index' do
    it 'iterate an array passing each element and its index to a block.' do
      expected_result_with_index = [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5]]
      int_arry.my_each_with_index { |e, i| result << [i, e] }
      expect(result).to eql(expected_result_with_index)
    end

    it 'iterate a hash passing each element and its index to a block.' do
      expected_result_with_index = [[[:a, 1], 0], [[:b, 2], 1], [[:c, 3], 2]]
      test_hash.my_each_with_index { |e, i| result << [e, i] }
      expect(result).to eql(expected_result_with_index)
    end

    it 'returns same array, unmodified when passed a block.' do
      int_arry.my_each_with_index { |e, i| result << [i, e] }
      expect(int_arry).to eql([1, 2, 3, 4, 5])
    end

    it 'returns same hash, unmodified when passed a block.' do
      test_hash.my_each_with_index { |e, i| result << [i, e] }
      expect(test_hash).to eql({ a: 1, b: 2, c: 3 })
    end

    it 'returns an <Enumerable> class. If no block is passed -- when caller is array.' do
      expect(int_arry.my_each_with_index).to be_an Enumerable
    end

    it 'returns an <Enumerable> class. If no block is passed -- when caller is hash.' do
      expect(test_hash.my_each_with_index).to be_an Enumerable
    end
  end

  describe '#my_select' do
    it 'returns a new filterd array of odd numbers' do
      odd_array = int_arry.my_select(&:odd?)
      expect(odd_array).to be_eql([1, 3, 5])
    end

    it 'returns a new array of filtered symbols' do
      filterd_syms_array = %i[foo cat hen].my_select { |s| s == :hen }
      expect(filterd_syms_array).to be_eql([:hen])
    end

    it 'returns same array, unmodified when passed a block.' do
      int_arry.my_select(&:even?)
      expect(int_arry).to eql([1, 2, 3, 4, 5])
    end

    it 'returns an <Enumerable> class. If no block is passed.' do
      expect(int_arry.my_select).to be_an Enumerable
    end
  end

  describe '#my_all?' do
    it 'return true if all elements passed to block is truthy' do
      boolean_result = int_arry.my_all? { |e| e > 0 }
      expect(boolean_result).to be true
    end

    it 'return false if any element passed to block is false' do
      boolean_result = int_arry.my_all? { |e| e > 1 }
      expect(boolean_result).to be false
    end

    it 'returns true if all elements is true without a block' do
      boolean_result = string_arry.my_all?
      expect(boolean_result).to be true
    end

    it 'returns false if any element is false without a block' do
      boolean_result = mix_arry.my_all?
      expect(boolean_result).to be false
    end

    it 'returns true if all elements are of given type' do
      boolean_result = string_arry.my_all?(String)
      expect(boolean_result).to be true
    end

    it 'returns false if any element is not of given type' do
      boolean_result = mix_arry.my_all?(Numeric)
      expect(boolean_result).to be false
    end

    it 'returns false if any element doesn\'t match a pattern' do
      boolean_result = %w[ant bear cat].my_all?(/t/)
      expect(boolean_result).to be false
    end

    it 'returns true when called on an empty array' do
      boolean_result = [].my_all?
      expect(boolean_result).to be true
    end
  end

  describe '#my_any?' do
    it 'return true if any elements passed to block is truthy' do
      boolean_result = int_arry.my_any? { |e| e > 3 }
      expect(boolean_result).to be true
    end

    it 'return false if all element passed to block is false' do
      boolean_result = int_arry.my_any? { |e| e > 5 }
      expect(boolean_result).to be false
    end

    it 'returns true if any element is true without a block' do
      boolean_result = string_arry.my_any?
      expect(boolean_result).to be true
    end

    it 'returns false if all elements are false without a block' do
      boolean_result = false_arry.my_any?
      expect(boolean_result).to be false
    end

    it 'returns true if any element is of given type' do
      boolean_result = mix_arry.my_any?(String)
      expect(boolean_result).to be true
    end

    it 'returns false if all elements are not of given type' do
      boolean_result = int_arry.my_any?(String)
      expect(boolean_result).to be false
    end

    it 'returns false if all elements do not match a pattern' do
      boolean_result = %w[fish bear hen].my_any?(/t/)
      expect(boolean_result).to be false
    end

    it 'returns false when called on an empty array' do
      boolean_result = [].my_any?
      expect(boolean_result).to be false
    end
  end

  describe '#my_none?' do
    it 'return true if any elements passed to block is false' do
      boolean_result = string_arry.my_none? { |e| e.length == 6 }
      expect(boolean_result).to be true
    end

    it 'return false if any element passed to block is true' do
      boolean_result = string_arry.my_none? { |e| e == 'egg' }
      expect(boolean_result).to be false
    end

    it 'returns true if all element is falsy without a block' do
      boolean_result = false_arry.my_none?
      expect(boolean_result).to be true
    end

    it 'returns false if any element is truthy without a block' do
      boolean_result = mix_arry.my_none?
      expect(boolean_result).to be false
    end

    it 'returns true if none of the element is of given type' do
      boolean_result = int_arry.my_none?(String)
      expect(boolean_result).to be true
    end

    it 'returns false if any element is of given type' do
      boolean_result = mix_arry.my_none?(String)
      expect(boolean_result).to be false
    end

    it 'returns true if all elements do not match a pattern' do
      boolean_result = %w[fish bear hen].my_none?(/t/)
      expect(boolean_result).to be true
    end

    it 'returns true when called on an empty array' do
      boolean_result = [].my_none?
      expect(boolean_result).to be true
    end
  end

  describe '#my_count' do
    it 'returns the size of array if no block is given' do
      expect(int_arry.my_count).to be_eql(5)
    end

    it 'returns the count of argument passed in an array' do
      expect(int_arry.my_count(5)).to be_eql(1)
    end

    it 'returns the count based on the predicate of a block' do
      expect(int_arry.my_count { |e| e > 2 }).to be_eql(3)
    end
  end

  describe '#my_map' do
    it 'returns <Enumerable> class if no proc or block given' do
      expect(int_arry.my_map).to be_an Enumerable
    end

    it 'returns new array when proc is passed' do
      expect(int_arry.my_map(test_proc)).to be_an Array
    end

    it 'returns new array when block is passed' do
      expect(int_arry.my_map { |e| e }).to be_an Array
    end

    it 'returns a newly transformed array when passed a proc' do
      expected_array = ['value is 1', 'value is 2', 'value is 3', 'value is 4', 'value is 5']
      expect(int_arry.my_map(test_proc)).to be_eql(expected_array)
    end

    it 'returns a newly transformed array when passed a block' do
      expected_array = ['value is 1', 'value is 2', 'value is 3', 'value is 4', 'value is 5']
      expect(int_arry.my_map { |e| "value is #{e}" }).to be_eql(expected_array)
    end

    it 'uses proc if proc and block are passed' do
      expected_array = [1, 4, 9, 16, 25]
      expect(int_arry.my_map(test_proc2) { |e| "value is #{e}" }).to be_eql(expected_array)
    end

    it 'does not change the caller' do
      expected_array = [1, 2, 3, 4, 5]
      int_arry.my_map(test_proc2)
      expect(int_arry).to be_eql(expected_array)
    end
  end

  describe '#my_inject' do
    it 'works with an addition symbol' do
      expect(int_arry.my_inject(:+)).to be_eql(15)
    end

    it 'works with an subtraction symbol' do
      expect(int_arry.my_inject(:-)).to be_eql(-13)
    end

    it 'works with an multiplication symbol' do
      expect(int_arry.my_inject(:*)).to be_eql(120)
    end

    it 'works with an division symbol' do
      expect(int_arry.my_inject(:/)).to be_eql(0)
    end

    it 'works with an memo (initial value) and symbol' do
      expect(int_arry.my_inject(4, :*)).to be_eql(480)
    end

    it 'works with an memo (initial value) and block' do
      expect(int_arry.my_inject(4) { |product, n| product * n }).to be_eql(480)
    end

    it 'works when passed a block' do
      longest = %w[cat sheep bear].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to be_eql('sheep')
    end

    it 'works with ranges and symbols' do
      the_sum = (1..5).my_inject(:+)
      expect(the_sum).to be_eql(15)
    end

    it 'works with ranges and blocks' do
      the_sum = (1..5).my_inject { |sum_, n| sum_ + n }
      expect(the_sum).to be_eql(15)
    end
  end
end
