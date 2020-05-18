each_with_index
The Enumerable#each_with_index method iterates over the members of a collection,
passing each element and its index to the associated block.
The value returned by the block is not used. each_with_index returns a reference to the original collection.

Write a method called each_with_index that behaves similarly for Arrays.
It should take an Array as an argument, and a block.
It should yield each element and an index number to the block. each_with_index should return a reference to the original Array.

Your method may use #each, #each_with_object, #inject, loop, for, while, or until
to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:

result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]
should output:

0 -> 1
1 -> 3
2 -> 36
true

------
Solution:

def each_with_index(array)
  counter = 0
  array.each do |i|
    yield(i, counter)
    counter += 1
  end
end

result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]
# 0 -> 1
# 1 -> 3
# 2 -> 36
# true

----
LS Solution: Same

def each_with_index(array)
  index = 0
  array.each do |item|
    yield(item, index)
    index += 1
  end
end

Discussion
Our solution is simple enough: it uses each to iterate through the Array,
while maintaining an index value that can be passed with the element value to the block.

At first glance, it might seem that we're missing a bit here: where's the return value?
As usual, every statement in Ruby returns a value,
and every method returns the value returned by the last statement executed.
In this case, the last statement executed is the each loop,
and each returns the Array it is used on, so the return value is array; just what we need.

--------
Student solutions:

def each_with_index(ary)
  index = 0
  until index == ary.length
    yield(ary[index], index)
    index += 1
  end
  ary
end

//

def each_with_index(arr)
  arr.each_with_object([-1]) { |el, i| yield(el, i[0] += 1) } && arr
end