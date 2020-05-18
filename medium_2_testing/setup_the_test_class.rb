# Setup the Test Class - Cash Register

# Let's start things from the ground up.
# We want to make a simple test suite for our CashRegister class.
# Setup the initial testing file.
# You don't have to have any tests in your test file.
# For this exercise, write everything you would need to start testing CashRegister,
# excluding the tests themselves (necessary requires, test class, etc.).

require 'minitest/reporters' #for color
Minitest::Reporters.use!
require 'minitest/autorun'

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test # making it a test class
end

Discussion:

Here's what we need to set up our test class for CashRegister.
First, we need to require all necessary libraries and files. "minitest/autorun" is first on the list,
as this is the library that will give us access to certain parts of the minitest framework that we need.

We also need to require the class we want to test and any classes it depends on.
In this case, we want to test CashRegister, but that class depends on collaboration with the Transaction class.
We've put those two classes in their own separate files, so two relative requires are necessary to gain access to both classes.

Finally, we have to set up the correct testing class.
By minitest convention, we'll be naming this class "Class name we want to test"Test: this ends up being, CashRegisterTest.
We also have to make sure that our test class subclasses from Minitest::Test.
This is a very important step, since if we didn't include this inheritance,
then this would be a plain Ruby class and not a test class.