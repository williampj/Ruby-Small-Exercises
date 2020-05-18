Iterators: True for None?
In the previous two exercises, you developed methods called any? and all?
that are similar to the standard Enumerable methods with the same names.
In this exercise, you will develop another of the methods in this family, none?.

Enumerable#none? processes elements in a collection by passing each element value to a block
that is provided in the method call. If the block returns true for any element, then #none? returns false.
Otherwise, #none? returns true.
Note in particular that #none? will stop searching the collection the first time the block returns true.

Write a method called none? that behaves similarly for Arrays. It should take an Array as an argument, and a block.
It should return true if the block returns false for all of the element values. Otherwise, it should return false.

Your method should stop processing elements of the Array as soon as the block returns true.

If the Array is empty, none? should return true, regardless of how the block is defined.

Your method may not use any of the following methods from the Array and Enumerable classes: all?, any?, none?, one?.
You may, however, use either of the methods created in the previous two exercises.

Examples:

none?([1, 3, 5, 6]) { |value| value.even? } == false
none?([1, 3, 5, 7]) { |value| value.even? } == true
none?([2, 4, 6, 8]) { |value| value.odd? } == true
none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
none?([1, 3, 5, 7]) { |value| true } == false
none?([1, 3, 5, 7]) { |value| false } == true
none?([]) { |value| true } == true

------
Solution:

def any?(collection, block) # from previous exercise
  collection.each { |element| return true if block.call(element) }
  false
end

def none?(collection, &block)
  !any?(collection, block) # !any? is equivalent to none (not any)
end

//

Solution 2: directly

def none?(collection)
  collection.each { |item| return false if yield(item) }
  true
end

p none?([1, 3, 5, 6]) { |value| value.even? } == false
p none?([1, 3, 5, 7]) { |value| value.even? } == true
p none?([2, 4, 6, 8]) { |value| value.odd? } == true
p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p none?([1, 3, 5, 7]) { |value| true } == false
p none?([1, 3, 5, 7]) { |value| false } == true
p none?([]) { |value| true } == true

Discussion:
The key to this solution is that #none? is merely the opposite of #any?.
#any? returns true if the collection contains any matches, false if does not.
#none? returns true if the collection does not contain any matches, false if does.

The easiest way to accomplish this is to just modify the #any? method we wrote earlier;
instead of returning true from the #each loop, we return false;
instead of returning false after the loop, we return true.

-----
Student solution:

# recursive:
def none?(arr, &block)
  return true if arr.empty?
  block.call(arr.first) ? false : none?(arr.drop(1), &block)
end

# using each: Converting the caller to a boolean + using && as conditional
def none?(arr)
  !!arr.each { |elem| yield(elem) && (return false) }
end

# using all?: testing if all? yields all false block return values
def none?(arr)
  all?(arr) { |elem| !yield(elem) }
end

# each_with_object - boolean
def none?(arr)
  arr.each_with_object(true) { |n| return false if yield(n) }
end
