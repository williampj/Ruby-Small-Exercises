Zipper
The Array#zip method takes two arrays, and combines them into a single array
in which each element is a two-element array where the first element is a value from one array,
and the second element is a value from the second array, in order.
For example:

[1, 2, 3].zip([4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]
Write your own version of zip that does the same type of operation.
It should take two Arrays as arguments, and return a new Array (the original Arrays should not be changed).
Do not use the built-in Array#zip method.
You may assume that both input arrays have the same number of elements.

Example:

zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

------
Solutions:

def zip(ary1, ary2)
  output_ary = []
  ary1.size.times do |i|
    output_ary << [ary1[i], ary2[i]]
  end
  output_ary
end

//

def zip(ary1, ary2)
  output_ary = []
  ary1.each_with_index do |i, indx|
    output_ary << [i, ary2[indx]]
  end
  output_ary
end

p zip([1, 2, 3], [4, 5, 6]) #== [[1, 4], [2, 5], [3, 6]]

------
LS Solution: Neat - calling with_object on with_index.

def zip(array1, array2)
  array1.each_with_index.with_object([]) do |(element, index), result|
    result << [element, array2[index]]
  end
end