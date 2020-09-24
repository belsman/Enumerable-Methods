require './my_enumerables'

describe Enumerable do
  let(:int_arry) { [1, 2, 3, 4, 5] }
  let(:string_arry) { %w[cat dog yam egg] }
  let(:mix_arry) { [100, nil, false, 'bake', 'hen'] }
  let(:test_hash) { { a: 1, b: 2, c: 3 } }
  let(:result) { [] }

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
end
