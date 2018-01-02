require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    if !@store[index]
      raise 'index out of bounds'
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if !check_index(0)
      raise 'index out of bounds'
    else
      el = @store[@length - 1]
      @store[@length - 1] = nil
      @length -= 1
      el
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @capacity == @length
      resize!
    end
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if !check_index(0)
      raise 'index out of bounds'
    else
      el = self[0]
      i = 1
      while i < @length
        self[i - 1] = self[i]
        i += 1
      end
      @length -= 1
      el
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @capacity == @length
      resize!
    end
    i = @length - 1
    while i >= 0
      self[i + 1] = self[i]
      i -= 1
    end
    self[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    !@store[index].nil?
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    new_store = StaticArray.new(@capacity)
    i = 0
    while i < self.length
      new_store[i] = @store[i]
      i += 1
    end
    @store = new_store
  end
end
