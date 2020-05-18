each_with_object

The Enumerable#each_with_object method iterates over the members of a collection, p
assing each element and an arbitrary object (usually a collection) to the associated block.
The value returned by the block is not used.
The object that is passed to the block is defined as an argument to each_with_object;
with each iteration, this object may be updated by the block.
When iteration is complete, the final value of the object is returned.

Write a method called each_with_object that behaves similarly for Arrays.
It should take an Array and an object of some sort as an argument, and a block.
It should yield each element and the object to the block. each_with_object should return the final value of the object.

If the Array is empty, each_with_object should return the original object passed as its second argument.

Your method may use #each, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument,
but must not use any other methods that iterate through an Array or any other collection.

Examples:

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
result == {}

-------
Solution: (same as LS solution)
# iterate through collection
#     pass element and object to the block which mutates the object
# return the object after iteration

def each_with_object(ary, object)
  ary.each { |i| yield(i, object) }
  object
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}


Discussion:

Implementing this method is easier than it sounds.
All that stuff about the "object" makes it sound harder than it really is.
In fact, all we need to do with that object is yield it (along with the element value) to our block for each element of the Array.
At the end, we just need to make sure we return that object.

---------
Student solutions:

# Leveraging #reduce's return behavior: setting obj as last expression.
def each_with_object(arr, obj)
  arr.reduce(obj) { |_, elm| yield(elm, obj); obj }
end

//
# recursive:
def each_with_object(arr, obj, &block)
  arr.empty? ? (return obj) : block.call(arr.first, obj)
  each_with_object(arr.drop(1), obj, &block)
end

//
# using Array#each:
def each_with_object(arr, obj)
  arr.each { |elem| yield(elem, obj) } && obj
end

//
# Differentiating between hash and array
def each_with_object(array, obj)
  result = obj
  case obj
  when []
    array.each do |i|
      result = yield(i, obj)
    end
  when {}
    array.each do |i|
    result[i] = yield(i, obj)
    end
  end
  result
end