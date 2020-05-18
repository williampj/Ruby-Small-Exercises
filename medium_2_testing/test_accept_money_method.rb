Test Accept Money Method - Cash Register

We now have the foundation of our CashRegister test class set up.
Let's start testing! We'll start with the CashRegister#accept_money method.
Write a test for the #accept_money method.

-----
Solution:

require 'minitest/autorun'
require 'minitest/reporters' #for color
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    cash_register = CashRegister.new(15000)
    transaction = Transaction.new(2000)
    transaction.amount_paid = 700
    assert_equal(15700, cash_register.accept_money(transaction))
  end
end

----
LS Solution:

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    register = CashRegister.new(1000)
    transaction = Transaction.new(20)
    transaction.amount_paid = 20

    previous_amount = register.total_money  # sandwich code: before
    register.accept_money(transaction)      # operation
    current_amount = register.total_money   # after

    assert_equal previous_amount + 20, current_amount
  end
end

Discussion:

When you first consider this test, it may seem really simple to write.
Yet, there is quite a bit of groundwork to lay here.
First, we need to create some objects to test the #accept_money method.
#accept_money is a method from class CashRegister, so we'll need an instance of that class.
We also need an instance of class Transaction. The method #accept_money takes a Transaction object as an argument.

Once we have our objects, we then set the amount_paid via the attr_accessor in the Transaction class.
This is the value we'll be checking. If our method does work as intended, then when we process a transaction,
the amount in register should increase exactly by the amount paid.

We test this value by setting variables that represent the money in the register before and after a transaction takes place.
Finally, we implement the approach/algorithm for this exercise with our assertion:
assert_equal previous_amount + 20, current_amount.
This assertion does indeed pass, and we have finished testing our accept money method.

-----
Student solution:
# I used a setup method to create instance variables for a register and transaction,
# assuming they would be useful for other tests as well as this one.

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test
  attr_reader :shoes, :register

  def setup
    @register = CashRegister.new(200)
    @shoes = Transaction.new(80)
    shoes.amount_paid = 100
  end

  def test_accept_money
    assert_equal(300, register.accept_money(shoes))
  end
end