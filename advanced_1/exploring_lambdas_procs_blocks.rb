Exploring Procs, Lambdas, and Blocks: Definition and Arity

This exercise covers material that you do not have to master.
We provide the exercise as a way to explore the differences between procs, lambdas, and blocks.

For this exercise, we'll be learning and practicing our knowledge of the arity of lambdas, procs, and implicit blocks.
Two groups of code also deal with the definition of a Proc and a Lambda, and the differences between the two.

Run each group of code below:
For your answer to this exercise, write down your observations for each group of code.
After writing out those observations, write one final analysis that explains the differences between procs, blocks, and lambdas.

# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
block_method_1('seal')

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}

-------
My Solutions:

# Group 1 - procs

my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')
#=>
<Proc:0x000000000120c550@testing.rb:2>
Proc
This is a .
This is a cat.

Proc:
# Definition:
Proc objects are blocks of code that have been bound to a set of local variables.
Once bound, the code may be called in different contexts and still access those variables.
Procs constitute their own class, with Object as parent class.

# Creation:
A proc is created either with Proc.new + block or Kernel.proc + block.
This proc is then assigned to a local variable to be passed around or called.

# Arity:
A proc has lenient arity - unassigned parameters will be assigned the value of nil, and
extra arguments passed to the proc will be ignored.


# Group 2 - lambdas
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }

#=>
#<Proc:0x0000000002900040@testing.rb:2 (lambda)>
#<Proc:0x0000000002900018@testing.rb:3 (lambda)>
Proc
This is a dog
testing.rb:2:in `block in <main>': wrong number of arguments (given 0, expected 1) (ArgumentError)
testing.rb:9:in `<main>': uninitialized constant Lambda (NameError)

Lambda:
# Definition:
Lambdas are a specific type of proc objects (blocks of code that have been bound to a set of local variables).
Once bound, the code may be called in different contexts and still access those variables.
Lambdas are objects of the Proc class (not their own class), so the call Lambda#new generates an error.

# Creation:
A lambda is created either with Kernel.lambda + block, or -> (block parameter) + block (without parameter)

# Arity:
A lambda has strict arity - an error is generated if the wrong number of parameters are passed to it.


# Group 3 - blocks
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
block_method_1('seal')
#=>
This is a .
`block_method_1': no block given (yield) (LocalJumpError)

Attached blocks have lenient arity like procs. Unassigned parameters are assigned to nil.

The Kernel#yield call from within a method will yield to a block argument.
It will, however, cause a LocalJumpError if there is not block passed to the method that it can yield to.


# Group 4 - blocks
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}
#=>
This is a turtle.
This is a turtle and a .
`block in <main>': undefined local variable or method `animal' for main:Object (NameError)

These examples show that an argument passed to a method can be passed back to
the accompanying block and assigned to the block parameter.

A Block passed as an argument to a method call has lenient arity, thus unassigned parameters
are assigned nil and extra arguments are ignored.

But local variables created within a method are not part of the binding of a block
created outside of that method, thus the local variable animal yields a NameError when
referenced in the block.

-----
LS Solution:

Group 1:
A new Proc object can be created with a call of proc instead of Proc.new
A Proc is an object of class Proc
A Proc object does not require that the correct number of arguments are passed to it.
If nothing is passed, then nil is assigned to the block variable.

Group 2:
A new Lambda object can be created with a call to lambda or ->. We cannot create a new Lambda object with Lambda.new
A Lambda is actually a different variety of Proc.
While a Lambda is a Proc, it maintains a separate identity from a plain Proc. This can be seen when displaying a Lambda: the string displayed contains an extra "(lambda)" that is not present for regular Procs.
A lambda enforces the number of arguments. If the expected number of arguments are not passed to it, then an error is thrown.

Group 3:
A block passed to a method does not require the correct number of arguments. If a block variable is defined, and no value is passed to it, then nil will be assigned to that block variable.
If we have a yield and no block is passed, then an error is thrown.

Group 4:
If we pass too few arguments to a block, then the remaining ones are assigned a nil value.
Blocks will throw an error if a variable is referenced that doesn't exist in the block's scope.

Comparison:
Lambdas are types of Proc's. Technically they are both Proc objects. An implicit block is a grouping of code, a type of closure, it is not an Object.
Lambdas enforce the number of arguments passed to them. Implicit block and Procs do not enforce the number of arguments passed in.