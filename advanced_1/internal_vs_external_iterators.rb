# Internal vs External Iterators

# This exercise covers material that you do not have to master.
# We provide the exercise as a way to demonstrate how Enumerator objects work.

# So far, we've used iterators often. You've seen the use of #each and #map used on various data structures,
# such as Arrays and Hashes.
# These methods make writing certain code a bit easier, at least when compared to a while or for loop.
# Yet, what we've seen thus far is only part of what is available.

# Whenever we use map or each on something like an Array, we're using something called "Internal Iteration".
# It's called that because the process and implementation of that iteration is hidden from us,
# and the process that allows us to progress through a collection is part of that hidden implementation.

# There's also "External Iteration". This is iteration that takes place at the behest of the user.
# Ruby gives us the option to use this type of iteration with the Enumerator class.
# For this exercise, lets take a bit of a tour of the capabilities of Enumerator.
# While we do that, let's make something interesting with it.

# In this exercise, your task is to create a new Enumerator object.
# When creating a new Enumerator, you may define what values are iterated upon.
# We'll want to create an Enumerator that can iterate over an infinite list of factorials.
# Once you make this new Enumerator, test it out by printing out the first 7 factorial values, starting with zero factorial.

# More specifically, print the first 7 factorials by using an "External Iterator".
# Once you have done so, reset your Enumerator.
# Finally, reprint those same 7 factorials using your Enumerator object as an "Internal Iterator".

# You can find almost everything you need for this exercise in the documentation for Enumerator.
# In particular, check out the ::new method; it should prove a good starting point for this exercise.

# Some further details about internal vs external iterators are mentioned at the start of that documentation,
# so make sure to read that section.
# Keep in mind that that section can be a bit dense; if you don't understand everything about it, that's ok.

# The wikipedia page on factorials may also be of some use.

# Two final hints:

# You'll only need 3 Enumerator methods to complete this exercise.
# An Enumerator also implements the Enumerable module.
# Keep this in mind, as it may make certain parts of this exercise easier to write.

# ------
# Solution:

factorials = Enumerator.new do |factorial|
  current = 0
  loop do
    factorial << (current < 2 ? 1 : (1..current).reduce(:*))
    current += 1
  end
end

//

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


p 7.times { puts factorials.next }
factorials.rewind

factorials.each_with_index do |factorial, index|
  puts "#{factorial} is factorial number #{index+1}"
  break if index >= 6
end


7.times { puts factorial.next }

factorial.rewind

factorial.each_with_index do |number, index|
  puts number
  break if index == 6
end

-------
Student solutions:

# 1:

fac = Enumerator.new do |y|
  a = b = 1
  loop do
    y << a
    a *= b
    b += 1
  end
end

p (1..7).map { fac.next }
p fac.rewind.take 7

# 2:

def factorial(n)
  (1..n).reduce(:*)
end

factorials = Enumerator.new do |yielder|
  number = 0
  loop do
    number += 1
    yielder.yield factorial(number)
  end
end

7.times { puts factorials.next }
factorials.rewind
factorials.first(7).each { |factorial| puts factorial }

# I first created a factorial method to get the logic of calculating factorials out of our enumerator —
# it's a pretty simple method because reduce is awesome.
# For my internal iterator, I used Enumerable#first which returns an array when called with an argument,
# and then just call each on the result.
# Nothing radically different than the LS solution, just refactored I guess.