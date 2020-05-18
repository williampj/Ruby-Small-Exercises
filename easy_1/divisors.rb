Divisors

Write a method that returns a list of all of the divisors of the positive integer passed in as an argument.
The return value can be in any sequence you wish.

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute

-----
Solution:

def divisors(integr)
  (1..integer).select {|n| integer % n == 0}
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute

///
Solution 2: With own iterator method taking a block:

def selector(integer)
  counter = 1
  while counter <= integer
    yield(counter)
    counter += 1
  end
end

def divisors(integer)
  output_array = []
  selector(integer) {|n| output_array << n if integer % n == 0}
  output_array
end

------
Further Exploration
You may have noticed that the final example took a few seconds, maybe even a minute or more, to complete.
This shouldn't be a surprise as we aren't doing anything to optimize the algorithm.
It's what is commonly called a brute force algorithm where you try every possible solution;
these are easy to write, but they don't always produce fast results.
They aren't necessarily bad solutions -- it depends on your needs --
but the speed of brute force algorithms should always be examined.

How fast can you make your solution go?
How big of a number can you quickly reduce to its divisors?
Can you make divisors(999962000357) return almost instantly?
(The divisors are [1, 999979, 999983, 999962000357].)
Hint: half of the divisors gives you the other half.

//

Student Solution 1: # adding iterated divisor number (increments) and quotient (decrements) until they cross/meet

def divisors(number)
  (1..number).each_with_object([]) do |n, array|
    quotient, remainder = number.divmod(n)
    array << n << quotient if remainder.zero?
    return array.uniq.sort if array.count(quotient) > 1
  end
end

//

Student Solution 2: # Manually creating denominator & inverse instead of using #divmod

def divisors(int)
  divs = [1, int]
  return divs.uniq if int == 1
  denom = 2
  until divs.include?(denom)
    inverse = int / denom
    if int % denom == 0
      divs.push(denom, inverse)
    end
    denom += 1
  end
  divs.uniq.sort
end