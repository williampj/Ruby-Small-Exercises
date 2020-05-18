Test Change Method - Cash Register

Write a test for the method, CashRegister#change.

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

  def test_change_method
    item.amount_paid = 1000
    assert_equal(300, register.change(item))
  end
end

-----
LS Solution:

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

# Other tests omitted for brevity

class CashRegisterTest < Minitest::Test
  def test_change
    register = CashRegister.new(1000)
    transaction = Transaction.new(30)
    transaction.amount_paid = 40

    assert_equal 10, register.change(transaction)
  end
end

Discussion:

For this test we set up our initial objects, one CashRegister object and one Transaction object.
We also make sure to set the amount paid.
Recall, that in the last exercise we set it up so that the amount paid and the transaction cost were the same.
In this case, we instead pay 40 dollars for a 30 dollar item. Hopefully we'll be getting some money back!
We test the actual functionality of our CashRegister#change method with the assertion: assert_equal 10, register.change(transaction).
We're expecting our change method to give back 10. After running the test it seems to do just that.
