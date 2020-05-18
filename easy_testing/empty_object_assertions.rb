Empty Object Assertions

Write a minitest assertion that will fail if the Array list is not empty.

-----
Solution:

assert_predicate(list, :empty?)

LS Solution: more direct

assert_empty list

Discussion:
#assert_empty tests whether its first argument responds to the method #empty? with a true value. You can use:

assert_equal true, list.empty?
#instead, but #assert_empty is clearer and issues a better failure message.

-----
Student solutions:

assert_equal(0, list.size)

assert_send([value, :empty?])
# assert_predicate has a better error message than #assert_send

assert_equal([], list)