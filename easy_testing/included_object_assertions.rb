Included Object Assertions

Write a minitest assertion that will fail if the 'xyz' is not in the Array list.

------
Solution:

assert_includes(list, 'xyz')
//
assert_equal(true, list.include?('xyz'))

Discussion:
#assert_includes tests whether its first argument contains the second argument. You can use:

assert_equal true, list.include?('xyz')
# instead, but #assert_includes is clearer and issues a better failure message.

------
Student solution: 

assert_send([list, :include?, 'xyz'])
      # receiver, message and arguments.