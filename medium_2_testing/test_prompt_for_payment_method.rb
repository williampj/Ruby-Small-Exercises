Test Prompt For Payment Method- Transaction
Write a test that verifies that Transaction#prompt_for_payment sets the amount_paid correctly.
#We've changed the transaction class a bit to make testing this a bit easier. 
The Transaction#prompt_for_payment now reads as:

def prompt_for_payment(input: $stdin) # We've set a default parameter for stdin
  loop do
    puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f  # notice that we call gets on that parameter
    break if valid_payment? && sufficient_payment?
    puts 'That is not the correct amount. ' \
          'Please make sure to pay the full cost.'
  end
end

-------
Solution: # very useful exercise

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

require_relative 'transaction'

class TransactionTest < Minitest::Test
  # read from input_object using #gets, and print to output_object using #puts (see: testing version of Transaction#prompt_for_payment)
  def test_prompt_for_correct_payment
    @item = Transaction.new(100) #item_cost
    correct_payment = StringIO.new('100')
    output_object = StringIO.new # We pass in a StringIO object so we can puts to it and test the output by calling StringIO#string on it.
    @item.prompt_for_payment(input:correct_payment, output: output_object)
    assert_equal(100, @item.amount_paid)
    assert_match(/How much are you paying?/, output_object.string)
  end

  def test_prompt_for_incorrect_payment
    @item2 = Transaction.new(50)
    incorrect_payment = StringIO.new("30\n 40\n 50")
    output_object = StringIO.new
    text = <<~MSG
          You owe $50.
          How much are you paying?
          That is not the correct amount. Please make sure to pay the full cost.
          You owe $50.
          How much are you paying?
          That is not the correct amount. Please make sure to pay the full cost.
          You owe $50.
          How much are you paying?
          MSG
    @item2.prompt_for_payment(input: incorrect_payment, output: output_object)
    assert_output(text) { puts output_object.string}
    assert_match(/That is not the correct amount/, output_object.string)
    assert_match(/Please make sure to pay the full cost./, output_object.string)
  end

  # using a File instead of StringIO: student solution modified to work in my TransactionTest class
  def test_prompt_for_payment
    transaction = Transaction.new(50)
    paid = File.new('paid.txt', 'r+')
    paid.puts('75\n')
    output_object = StringIO.new
    transaction.prompt_for_payment(input: File.new(paid), output: output_object)
    paid.close
    assert_equal(75, transaction.amount_paid)
  end
end

-----
LS Solution:

Approach/Algorithm
For this exercise, we'll need to simulate the user input.
Our tests need to be automated, so we can't be prompting the user with Kernel#gets.
Look into the class StringIO. The key to solving this exercises lies there.
This will be testing a Transaction class method.
So it may be best to include this test in a new test file related to the Transaction class.

Solution:

require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('30\n') # not necessary with \n because it gets chomped in the #prompt_for_payment method
    transaction.prompt_for_payment(input: input)
    assert_equal 30, transaction.amount_paid
  end
end

Discussion:

This one is a bit tricky. The solution for this exercise involves using StringIO as a mock object.
We need a way to simulate Kernel#gets and the method StringIO#gets allows us to do just that.
In our test we can set the input as StringIO.new('30').
When we pass this to Transaction#prompt_for_payment and call input.gets.chomp we'll get back the String stored in our input object.
This will return 30 and that will get assigned to @amount_paid.

Finally, for our assertion, we make sure that @amount_paid was set correctly.
If it was set correctly, then our expected value of 30 should equal the value returned by the getter for @amount_paid

---------
Student solutions:

# Testing for invalid message output

def test_prompt_for_payment
  item_cost   = 199
  transaction = Transaction.new(item_cost)

  input  = StringIO.new("198\n199") # Kernel#gets automatically splits inputs by "\n"
  # we simulate input at first iteration as 198, next input as 199; this is to ensure that we can break out of the loop.
  output = StringIO.new
  transaction.prompt_for_payment(input: input, output: output)
  # message is written to output whenever Kernel#puts is called

  assert_match(/That is not the correct amount/, output.string)
  assert_match(/Please make sure to pay the full cost./, output.string)
end

# with some modification made to the prompt_for_payment method:

def prompt_for_payment(input: $stdin, output: $stdout)
  # additional output param here, to save our output to the output variable
  loop do
    output.puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f
    break if valid_payment? && sufficient_payment?
    output.puts 'That is not the correct amount. ' \
         'Please make sure to pay the full cost.'
  end
end

