require './my_enumerables'

describe Enumerable do
  let(:int_arry) { [1, 2, 3, 4, 5] }
  let(:test_hash) { { a: 1, b: 2, c: 3} }
  let(:result) { [] }

  describe "#my_each" do
    it "returns same array, unmodified when passed a block." do
      result = int_arry.my_each { |e| e * 3}
      expect(result).to equal(int_arry)
    end

    it "returns same hash, unmodified when passed a block." do
      result =  test_hash.my_each { |k, v| v * 2 }
      expect(result).to equal(test_hash)
    end

    it "returns an <Enumerable> class. If no block is passed -- when caller is array." do
      expect(int_arry.my_each).to be_an Enumerable
    end

    it "returns an <Enumerable> class. If no block is passed -- when caller is hash." do
      expect(test_hash.my_each).to be_an Enumerable
    end
  end

  describe "my_each_with_index" do
    it "iterate an array passing each element and its index to a block." do
      expected_result_with_index = [ [0, 1], [1, 2], [2, 3], [3, 4], [4, 5] ]
      int_arry.my_each_with_index { |e, i| result << [i, e] }
      expect(result).to eql(expected_result_with_index)
    end

    it "iterate a hash passing each element and its index to a block." do
      expected_result_with_index = [[[:a, 1], 0], [[:b, 2], 1], [[:c, 3], 2]]
      test_hash.my_each_with_index { |e, i| result << [e, i] }
      expect(result).to eql(expected_result_with_index)
    end

    it "returns same array, unmodified when passed a block." do
      int_arry.my_each_with_index { |e, i| result << [i, e] }
      expect(int_arry).to eql([1, 2, 3, 4, 5])
    end

    it "returns an <Enumerable> class. If no block is passed -- when caller is array." do
      expect(int_arry.my_each_with_index).to be_an Enumerable
    end

    it "returns an <Enumerable> class. If no block is passed -- when caller is hash." do
      expect(test_hash.my_each_with_index).to be_an Enumerable
    end
  end
end