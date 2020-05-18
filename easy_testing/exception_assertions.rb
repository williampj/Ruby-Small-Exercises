Exception Assertions

Write a minitest assertion that will fail unless employee.hire raises a NoExperienceError exception.

---
Solution:

assert_raises(NoExperienceError) { employee.hire }

//

assert_raises NoExperienceError do
  employee.hire
end

Discussion:
#assert_raises checks if the given block raises an exception of the named type. If it does not, the assertion fails.

-----
Student solutions: Elaborate OOP solutions

#1
class NoExperienceError < StandardError; end  # Defining Error class

class Employee
  def initialize(experience = false)
    @experience = experience
  end

  def hire
    raise NoExperienceError unless @experience
    @hired = true
  end
end

class RaiseExceptionTest < MiniTest::Test # The testing class, runs the test instance methods
  def test_exception
    assert_raises NoExperienceError do
      employee = Employee.new
      employee.hire
    end
  end
end

//

#2
NoExperienceError = Class.new(StandardError) # Creating a new class (NoExperienceError) with parent class (StandardError)

class TestClass < Minitest::Test
  def test_no_experience_error
    employee = 'employee'
    employee.define_singleton_method(:hire) { raise NoExperienceError } # creates instance method only for the caller - employee
    assert_raises(NoExperienceError) { employee.hire }
  end
end