# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'
require 'byebug'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @min_val = nil
    @max_val = nil
  end

  def enqueue(val)

    object = {
      val: val,
      max: nil
    }

    if !@max_val || val > @max_val
      object[:max] = val
      @max_val = val
    else
      object[:max] = @max_val
    end

    @store.push(object)

  end

  def dequeue
    object = @store.shift
    if object[:max] == @max_val
      @max_val = nil
      i = 0
      while i < @store.length
        if !@max_val || @max_val < @store[i][:val]
          @max_val = @store[i][:val]
        end
        i += 1
      end
      i = 0
      while i < @store.length
        @store[i][:max] = @max_val
        i += 1
      end
    end
    object
  end

  def max
    @store[-1][:max]
  end

  def length
    @store.length
  end

end
