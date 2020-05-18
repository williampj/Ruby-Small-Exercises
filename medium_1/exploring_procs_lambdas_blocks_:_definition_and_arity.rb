For this exercise, we'll be learning and practicing our knowledge of the arity of lambdas, procs, and implicit blocks.
Two groups of code also deal with the definition of a Proc and a Lambda, and the differences between the two.
Run each group of code below: For your answer to this exercise, write down your observations for each group of code.
After writing out those observations, write one final analysis that explains the differences between procs, blocks, and lambdas.

# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
p my_proc.call
p my_proc.call('cat')

# # Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
p my_lambda.call('dog')
my_lambda.call # Argument error, lambdas have strict arity, so here we need an argument.
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" } # Error


# # Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
# block_method_1('seal')

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}." #lenient arity, seal references nil value
end
block_method_2('turtle') { puts "This is a #{animal}."} # method must pass in animal variable to the block parameter to be within the block scope. Here animal local variable is contained within the block_method_2 method.

-----
Solution/answer

Group 1: Procs behave just like blocks. They are in essence just a block stored in a variable,
so they are blocks that can be passed around. They have a lenient arity like blocks.
They do have their own class though. We define it as a block with the keyword 'proc' in front of the block.

Group 2: Lambdas
Interestingly, lambdas belong to the proc class. We can therefore not instantiate a Lambda class.
They are defined either with keyword 'lambda' in front of the block, or with dash-right arrow '->'
in front of the block and stored in a variable.
A key difference is that lambdas have strict arity (arguments must match block parameters).
Lambdas act more like methods.

Group 3:-4 Blocks. Methods that yield to a block require a block attached as argument to the method invocation.
Blocks have lenient arity, so empty parameters are assigned nil value, and extra arguments are simply ignored.

-----
LS Solution:

Solution
Group 1:

1. A new Proc object can be created with a call of proc instead of Proc.new
2. A Proc is an object of class Proc
3. A Proc object does not require that the correct number of arguments are passed to it.
If nothing is passed, then nil is assigned to the block variable.

Group 2
1. A new Lambda object can be created with a call to lambda or ->. We cannot create a new Lambda object with Lambda.new
2. A Lambda is actually a different variety of Proc.
3. While a Lambda is a Proc, it maintains a separate identity from a plain Proc.
This can be seen when displaying a Lambda: the string displayed contains an extra "(lambda)" that is not present for regular Procs.
4. A lambda enforces the number of arguments. If the expected number of arguments are not passed to it, then an error is thrown.

Group 3
1. A block passed to a method does not require the correct number of arguments. If a block variable is defined, and no value is passed to it, then nil will be assigned to that block variable.
2. If we have a yield and no block is passed, then an error is thrown.

Group 4
1. If we pass too few arguments to a block, then the remaining ones are assigned a nil value.
2. Blocks will throw an error if a variable is referenced that doesn't exist in the block's scope.

Comparison

1. Lambdas are types of Proc's. Technically they are both Proc objects.
An implicit block is a grouping of code, a type of closure, it is not an Object.
2. Lambdas enforce the number of arguments passed to them. Implicit block and Procs do not enforce the number of arguments passed in.