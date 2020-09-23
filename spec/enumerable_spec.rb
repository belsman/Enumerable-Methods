require './my_enumerables'

describe Enumerable do
  let(:int_arry) { [1, 2, 3, 4, 5] }
  let(:test_hash) { { a: 1, b: 2, c: 3, d: 4, e: 5} }

  describe "#my_each" do
    it "returns same array, unmodified when passed a block." do
      result = int_arry.my_each { |e| e * 3}
      expect(result).to equal(int_arry)
    end

    it "returns same hash, unmodified when passed a block." do
      result =  test_hash.my_each { |k, v| v * 2 }
      expect(result).to equal(test_hash)
    end

    it "returns an <Enumerable> class. If no block is passed." do
      expect(int_arry.my_each).to be_an Enumerable
    end

    it "returns an <Enumerable> class. If no block is passed." do
      expect(test_hash.my_each).to be_an Enumerable
    end
  end
end