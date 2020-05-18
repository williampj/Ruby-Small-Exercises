max_by
The Enumberable#max_by method iterates over the members of a collection, passing each element to the associated block.
It then returns the element for which the block returned the largest value.

Write a method called max_by that behaves similarly for Arrays.
It should take an Array and a block, and return the element that contains the largest value.

If the Array is empty, max_by should return nil.

Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until
to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:

max_by([1, 5, 3]) { |value| value + 2 } == 5
max_by([1, 5, 3]) { |value| 9 - value } == 1
max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
max_by([-7]) { |value| value * 3 } == -7
max_by([]) { |value| value + 5 } == nil

-------
Solution:

def max_by(collection)
  collection.inject { |memo, element| yield(memo) >= yield(element) ? memo : element }
end

p max_by([1, 5, 3]) { |value| value + 2 } #== 5
p max_by([1, 5, 3]) { |value| 9 - value } #== 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } #== 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } #== [3, 4, 5]
p max_by([-7]) { |value| value * 3 } #== -7
p max_by([]) { |value| value + 5 } #== nil

----
Student solution:

def max_by(array)
  max_value = array.first
  array.each do |arr|
    max_value = arr if yield(arr) > yield(max_value)
  end
  max_value
end

-------
LS Solution: cumbersome

def max_by(array)
  return nil if array.empty?

  max_element = array.first
  largest = yield(max_element)

  array[1..-1].each do |item|
    yielded_value = yield(item)
    if largest < yielded_value
      largest = yielded_value
      max_element = item
    end
  end

  max_element
end

Discussion:
The first part of our solution simply handles the edge case of an empty Array.
According to the requirements, we just need to return nil for an empty Array, so that's what we've done.

The rest of the exercise has two tricky parts:
first, we need to select a reasonable initial value to be compared against each block return value,
then we need to iterate over the Array while keeping track of both the largest value returned by the block,
and the value of the element associated with that largest value.

The first part isn't too bad. Obviously, 0 won't work as the largest value: it would cause the 4th test to fail since -7 < 0.
We could also try -Float::INFINITY, which would work in most cases,
but what happens if the block returns something other than a number?
For instance, our 3rd example has a block that returns Strings,
which can't be successfully compared against -Float::INFINITY.
The answer is to pass the first item in the Array to the block, and then use the return value as the initial largest value.

The second tricky part also isn't too bad; all we need to do is remember which element returned the largest value to date.
We track this element in max_element, which we initialize to the first element of the Array.

Once this plan is in place, all we need to do is iterate through the remaining Array elements
and find the largest block return value and its associated element.

