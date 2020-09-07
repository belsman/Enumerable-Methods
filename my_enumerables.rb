module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    for i in self
      yield(i)
    end
    self
  end
end
