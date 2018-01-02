# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
    @length = length
  end

  # O(1)
  def [](index)
    index = @length + index if index < 0
    @store[index]
  end

  # O(1)
  def []=(index, value)
    index = @length + index if index < 0
    @store[index] = value
  end

  protected
  attr_accessor :store
end
