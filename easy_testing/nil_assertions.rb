Nil Assertions

Write a minitest assertion that will fail if value is not nil.

---
Solution:

assert_nil(value)
/
assert_nil value


Discussion:
#assert_nil tests whether its first argument is nil. You can use:
assert_equal nil, value
#instead, but #assert_nil is clearer and issues a better failure message.

-------
Student solutions:

assert_instance_of(NilClass, value)
//
assert_predicate(value, :nil?)
# assert_predicate calls the named method on your target object and passes if the result is truthy:

