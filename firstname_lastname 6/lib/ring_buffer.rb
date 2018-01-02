require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    if !@store[@start_idx + index]
      raise 'index out of bounds'
    else
      @store[@start_idx + index]
    end
  end

  # O(1)
  def []=(index, val)
    @store[@start_idx + index] = val
  end

  # O(1)
  def pop
    if !check_index(0)
      raise 'index out of bounds'
    else
      el = self[@length - 1]
      self[@length - 1] = nil
      @length -= 1
      el
    end
  end

  # O(1) ammortized
  def push(val)
    resize! if @capacity == @length
    self[@length] = val
    @length += 1
  end

  # O(1)
  def shift
    el = self[0]
    self[0] = nil
    @start_idx += 1
    @length -= 1
    el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @capacity == @length
    @start_idx -= 1
    self[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    !self[index].nil?
  end

  def resize!
    @capacity = @capacity * 2
    new_store = StaticArray.new(@capacity)
    i = 0
    while i < @length
      new_store[i] = self[i]
      i += 1
    end
    @store = new_store
    @start_idx = 0
  end
end
