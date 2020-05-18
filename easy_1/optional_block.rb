Optional Blocks
Write a method that takes an optional block.
If the block is specified, the method should execute it, and return the value returned by the block.
If no block is specified, the method should simply return the String 'Does not compute.'.

Examples:

compute { 5 + 3 } == 8
compute { 'a' + 'b' } == 'ab'
compute == 'Does not compute.'

---
Solution:

def compute
  block_given? ? yield : "Does not compute."
end

p compute { 5 + 3 } == 8
p compute { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'

------
Discussion:

The Kernel#block_given? method can be used to determine if a block has been passed to a method, 
even if there is no mention of a block in the method arguments. 
We use it here to detect when we should return 'Does not compute.', 
and when we should return the value yielded by the block.

------
Other solutions:

def compute
  yield rescue "Does not compute."
end

def compute 
  return "Does not compute." unless block_given?
  yield 
end 

-------
Further Exploration
Modify the compute method so it takes a single argument and yields that argument to the block. 
Provide at least 3 examples of calling this new version of compute, including a no-block call.

def compute(*args)
  return yield(*args) if block_given? 
  "Does not compute."
end

p compute('x', 'y', 'z') {|arg1, arg2, arg3| arg1 + arg2 + arg3 } 
p compute(124) {|arg| puts arg} 
p compute 