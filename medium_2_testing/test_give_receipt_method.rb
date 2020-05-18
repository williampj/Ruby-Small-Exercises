# Test Give Receipt Method - Cash Register

# Write a test for method CashRegister#give_receipt that ensures it displays a valid receipt.

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  attr_reader :register, :item
  def setup
    @register = CashRegister.new(5000)
    @item = Transaction.new(700)
  end

  def test_give_receipt
    item.amount_paid = 700
    assert_output("You've paid $700.\n") {register.give_receipt(item)}
  end
end

------
LS Solution:

Approach/Algorithm
This will be something a bit new. This method outputs something to stdout.
So, that is what you will want to test. Remember to keep the minitest docs close by, as they should prove useful for this exercise.

Solution:

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test

  # Other tests omitted for brevity

  def test_give_receipt
    item_cost = 35
    register = CashRegister.new(1000)
    transaction = Transaction.new(item_cost)
    assert_output("You've paid $#{item_cost}.\n") do
      register.give_receipt(transaction)
    end
  end
end

Discussion:

For this test, we'll be testing that our method outputs a certain message.
To test this, we need to use the assertion, assert_output.
Outputting a message is also considered a side effect, so it is something we would want to test.
This is especially true since our message should reflect a state of our current transaction.
assert_output uses a slightly different syntax than something like assert and assert_equal.

We pass in code that will produce the "actual" output via a block.
Then, internally, assert_ouput compares that output to the expected value passed in as an argument.
In this case that expected value is: "You've paid $#{item_cost}.\n"
Notice that we include a newline character at the end there.
Any little nuances related to the implementation of our method have to be taken into account.
puts appends a newline to the message that is output.
We must include that newline character in our expected value as well when making an assertion with assert_output.

-----
Student solution: Regex possible

def test_give_receipt
  cash_register = CashRegister.new(1500)
  transaction = Transaction.new(250)
  transaction.amount_paid = 300

  assert_output(/You\'ve paid \$250./) {cash_register.give_receipt(transaction)}
end