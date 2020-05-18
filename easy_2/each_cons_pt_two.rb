each_cons (Part 2)
In the previous exercise, we wrote a method that emulates Enumerable#each_cons,
but limited our method to handling 2 elements at a time.
Enumerable#each_cons can actually handle any number of elements at a time: 1, 2, 3, or more.

Update your each_cons method so it takes an argument that specifies how many elements should be processed at a time.

Your method may use #each, #each_index, #each_with_object, #inject, loop, for, while, or until
to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
hash == {}

------
Solution:

def each_cons(coll, seq = 2)
  pointer = 0
  while pointer + seq <= coll.size
    yield(*coll[pointer, seq])
    pointer += 1
  end
  nil
end

//

def each_cons(ary, cons)
  ((ary.size - cons) + 1).times do |n|
    ary_values = (n...n+cons).map { |i| ary[i]}
    yield(*ary_values)
  end
  nil
end

//
# Refactored inspired by LS slice method call
def each_cons(ary, cons)
  ((ary.size - cons) + 1).times do |n|
    yield(*ary[n...n+cons])
  end
  nil
end

------
LS Solution: #using a slice type call *array[index..(index + n - 1)]
def each_cons(array, n)
  array.each_index do |index|
    break if index + n - 1 >= array.size
    yield(*array[index..(index + n - 1)])
  end
end

Discussion:
This exercise would be pretty hard if you hadn't already done the bulk of the work in the previous exercise.
Even so, it can be tricky.

As before, you need to know when to stop iterating.
This can be handled pretty easily by realizing that the previous exercise just had n == 2,
and we stopped processing when index + 1, or index + 2 - 1 was greater than or equal to the Array size.
This translates pretty naturally to testing whether index + n - 1 is greater than or equal to the Array size.

Slightly trickier is passing a variable number of elements to the block; we do this using the "splat" operator (*)
together with a slice of the array that covers n elements starting at the current index.

------
Student solution: Similar

def each_cons(arr, num)
  (0..(arr.size - num)).each { |index| yield(*arr[index, num]) }
  nil
end

//

def each_cons(collection, cons)
  count = 0
  while count + (cons - 1) < collection.size
    yield(*collection.slice(count, cons))
    count += 1
  end
end