drop_while

The Enumerable#drop_while method begins by iterating over the members of a collection,
passing each element to the associated block until it finds an element for which the block returns false or nil.
It then converts the remaining elements of the collection (including the element that resulted in a falsey return) to an Array,
and returns the result.

Write a method called drop_while that behaves similarly for Arrays. It should take an Array as an argument, and a block.
It should return all the elements of the Array, except those elements at the beginning of the Array
that produce a truthy value when passed to the block.

If the Array is empty, or if the block returns a truthy value for every element, drop_while should return an empty Array.

Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until
to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:

drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| true } == []
drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
drop_while([]) { |value| true } == []

---------
Solution:

def drop_while(ary)
  counter = 0
  while counter < ary.size do
    break unless yield(ary[counter])
    counter += 1
  end
  ary.slice(counter..-1)
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []

-----------
LS Solution: Nearly the same

def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end

Discussion:

While we could use each or each_with_index, our solution employs a simple while loop instead;
while makes it obvious that we want to stop prematurely, since we know that we may not be iterating through the entire Array.

Once we've skipped over the elements for which the block returns true,
all we need to do is extract the remaining elements from the Array,
which we do with array[index..-1]; this slicing syntax extracts a slice of the Array starting at index,
and ending with the final element at index -1.

-------
Student solution:

def drop_while(array)
  array.each_with_index { |item, idx| return array[idx..-1] unless yield(item) }
  []
end
