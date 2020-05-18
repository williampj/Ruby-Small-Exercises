Type Assertions

Write a minitest assertion that will fail if value is not an instance of the Numeric class exactly. 
value may not be an instance of one of Numeric's superclasses.

-----
Solution:

assert_instance_of(Numeric, value)

Discussion: 

#assert_instance_of uses Object#instance_of? to ensure that its second argument is an instance of the class named as its first argument.

-----
Student solutions:

assert_same(Numeric, value.class.ancestors.first)

assert_equal Numeric, value.class

assert value.instance_of?(Numeric)
