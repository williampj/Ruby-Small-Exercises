Internal vs External Iterators

So far, we've used iterators often. You've seen the use of #each and #map used on various data structures, such as Arrays and Hashes.
These methods make writing certain code a bit easier, at least when compared to a while or for loop.
Yet, what we've seen thus far is only part of what is available.

Whenever we use map or each on something like an Array, we're using something called "Internal Iteration".
It's called that because the process and implementation of that iteration is hidden from us,
and the process that allows us to progress through a collection is part of that hidden implementation.

There's also "External Iteration". This is iteration that takes place at the behest of the user.
Ruby gives us the option to use this type of iteration with the Enumerator class.
For this exercise, lets take a bit of a tour of the capabilities of Enumerator.
While we do that, let's make something interesting with it.

In this exercise, your task is to create a new Enumerator object.
When creating a new Enumerator, you may define what values are iterated upon.
We'll want to create an Enumerator that can iterate over an infinite list of factorials.
Once you make this new Enumerator, test it out by printing out the first 7 factorial values, starting with zero factorial.

More specifically, print the first 7 factorials by using an "External Iterator".
Once you have done so, reset your Enumerator.
Finally, reprint those same 7 factorials using your Enumerator object as an "Internal Iterator".

You can find almost everything you need for this exercise in the documentation for Enumerator.
In particular, check out the ::new method; it should prove a good starting point for this exercise.
Some further details about internal vs external iterators are mentioned at the start of that documentation,
so make sure to read that section.
Keep in mind that that section can be a bit dense; if you don't understand everything about it, that's ok.

The wikipedia page on factorials may also be of some use.

Two final hints:

You'll only need 3 Enumerator methods to complete this exercise.
An Enumerator also implements the Enumerable module. Keep this in mind, as it may make certain parts of this exercise easier to write.

-------
Solution:

#External - manually driving every iteration with keyword next
enum = Enumerator.new do |factorial|
  index = 0
  next_num = 1
  loop do
    factorial << next_num
    index += 1
    next_num = next_num*index
  end
end

7.times { puts enum.next }

enum.rewind

#Internal - from LS, using built-in internal iterator each_with_index

enum.each_with_index {|i, index| puts i; break if index == 6 }

-------
LS Solution:

factorial = Enumerator.new do |yielder|
  accumulator = 1
  number = 0
  loop do
    accumulator = number.zero? ? 1 : accumulator * number
    yielder << accumulator
    number += 1
  end
end

7.times { puts factorial.next } # externally gene

factorial.rewind

factorial.each_with_index do |number, index|
  puts number
  break if index == 6
end

Discussion:

Most of the work for solving this problem relates to creating our new Enumerator object.
We can get a good start at understanding how to do this by referencing the Enumerator::new method.
It shows how to define a new Enumerator that iterates over Fibonacci numbers.
We'll start with that as a template, and alter it to iterate over factorials instead.
For iterating over factorials, we'll need two variables: one to track which number factorial we are on,
and another store the cumulative value of all prior factorials.
We use accumulator for the latter, and we use number for the former.

When defining an external iterator, we set the next value in the iteration by calling yielder << value.
In this case, we use accumulator for value; it sets the current factorial value.

To use our Enumerator object as an internal and external iterator, we utilize two different groups of code.
First, we call factorial.next seven times.
This is us, as a user explicitly iterating through factorials, so this is an instance of using factorial as an "External Iterator".

Next, we reset the Enumerator object using #rewind.
If we didn't do this, we would continue grabbing the next factorial object with each subsequent iteration.

Finally, we utilize our Enumerator object as an "Internal Iterator".
We call the Enumerable method, each_with_index on our Enumerator object.
It is important to break at index == 6 otherwise, we would output factorials ad infinitum.

-------
Student solution:

def factors!(n)
  factors_array = []
  n.downto(1) do |num|
    factors_array << num
  end
  factors_array
end

ALL_FACTORIAL_VALUES =
  Enumerator.new do |all_factorials|
    0.upto(Float::INFINITY) do |num|
      all_factorials << (num.zero? ? 1 : factors!(num).reduce(:*))
    end
  end

7.times { puts ALL_FACTORIAL_VALUES.next }

ALL_FACTORIAL_VALUES.rewind  # rewind is not needed for internal iteration

ALL_FACTORIAL_VALUES.each_with_index do |factorial, index|
  break if index == 7
  puts factorial
end

//

factorial = Enumerator.new do |y|
  num, multiplier = 1, 0
  loop do
    y << num
    num *= (multiplier += 1)
  end
end

# External
eval('p factorial.next;' * 7)
# we don't need to call #rewind here because using #next doesn't affect most
#  internal enumeration methods

# Internal
puts factorial.take(7)