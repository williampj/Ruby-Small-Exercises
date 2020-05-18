From-To-Step Sequence Generator

The Range#step method lets you iterate over a range of values where each value in the iteration is the previous value plus a "step" value.
It returns the original range.

Write a method that does the same thing as Range#step, but does not operate on a range.
Instead, your method should take 3 arguments: the starting value, the ending value,
and the step value to be applied to each iteration.
Your method should also take a block to which it will yield (or call) successive iteration values.

Example:

step(1, 10, 3) { |value| puts "value = #{value}" }
#=> value = 1
#=> value = 4
#=> value = 7
#=> value = 10

What do you think would be a good return value for this method, and why?

------
Solution: Choose to return nil

def step(first, last, step_size)
  current = first
  while current <= last
    yield(current)
    current += step_size
  end
end

p step(1, 10, 3) { |value| puts "value = #{value}" }

-----
LS Solution: Basically the same

def step(start_point, end_point, increment)
  current_value = start_point
  loop do
    yield(current_value)
    break if current_value + increment > end_point
    current_value += increment
  end
  current_value
end

Discussion:
In this solution start_point is where we begin, end_point is the maximum value to step up to,
and increment is the amount we want to step by on each iteration.

current_value is yielded to the block and then incremented on each iteration.
We do not want to step beyond end_point, so we exit the loop when current_value + increment > end_point.
Finally, we return current_value.

There's no particular reason why we choose to return current_value other than the fact that it is a reasonably sensible value.
Range#step returns self (this is, the original Range object), but that doesn't work for us.
Another reasonable return value might be nil, or perhaps the last value returned by the block.

----
Student solution:
I chose to make the return value an Array of the elements stepped through.
I made the block optional so that another method could be chained directly to that return value.
This just seemed like a return value that could be useful.

def step(starting, ending, step)
  starting = starting
  return_array = []

  while starting <= ending
    yield(starting) if block_given?
    return_array << starting
    starting += step
  end

  return_array
end

# Example:

p step(1, 10, 3) { |value| puts "value = #{value}" }
p step(1, 10, 3).map { |element| element.to_s + 'a' }