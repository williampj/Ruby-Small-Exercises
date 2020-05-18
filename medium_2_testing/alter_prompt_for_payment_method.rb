Alter Prompt For Payment Method - Transaction
You may have noticed something when running the test for the previous exercise.
And that is that our minitest output #wasn't that clean.
We have some residual output from the Transaction#prompt_for_payment method.

Run options: --seed 52842

# Running:

You owe $30.
How much are you paying?
.

Finished in 0.001783s, 560.7402 runs/s, 560.7402 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

Transaction#prompt_for_payment has a call to Kernel#puts and that output is showing up when we run our test.
Your task for this exercise is to make it so that we have "clean" output when running this test.
We want to see something like this:

Run options: --seed 4957

# Running:

.

Finished in 0.000919s, 1087.9984 runs/s, 1087.9984 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

-----
Solution: Taken care of by printing output to a passed in StringIO file within Transaction#prompt_for_payment
instead of printing to $stdout (screen)

# Same answer as test_prompt_for_payment_method.rb while adding #silenced + #test_prompt_for_payment

class TransactionTest < Minitest::Test
  def test_prompt_for_correct_payment
    @item = Transaction.new(100) #item_cost
    input_object = StringIO.new('100')
    output_object = StringIO.new
    @item.prompt_for_payment(input:input_object, output: output_object)
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

  def silenced
    $stdout = StringIO.new
    yield
  ensure
    $stdout = STDOUT
  end

  def test_prompt_for_payment
    transaction = Transaction.new(30)
    transaction.amount_paid = 0
    io = StringIO.new('30')
    silenced do
      transaction.prompt_for_payment(input: io)
    end
    assert_equal 30, transaction.amount_paid
  end
end

#from transaction.rb

def prompt_for_payment(input: $stdin, output: $stdout) # default parameters for input/output, otherwise passed in File/StringIO instances
  loop do
    output.puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f  # calling gets on either a passed in StringIO/File instance, or default on $stdin as usual
    break if valid_payment? && sufficient_payment?
    output.puts "That is not the correct amount. Please make sure to pay the full cost." # save soutput to passed in StringIO/File instance
  end                                                                                    # or default to screen as usual
end


----
LS Solution & explanation:

Approach/Algorithm:
The key to this exercise lies once again in the StringIO class.
Similar to the previous exercise, this will involve using another mock object, but for output this time.
You may make changes to the Transaction#prompt_for_payment method to fulfill the requirements of this exercise.
One last thing to note is that the solution does not require you to remove any calls to puts

Solution:
require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('30')
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal transaction.amount_paid, 30
  end
end

def prompt_for_payment(input: $stdin, output: $stdout)
  loop do
    output.puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f
    break if valid_payment? && sufficient_payment?
    output.puts 'That is not the correct amount. ' \
         'Please make sure to pay the full cost.'
  end
end

Discussion:
For this exercise we'll have to work on two things.
First, we'll create a mock object to use in prompt_for_payment_test. output = StringIO.new
Unlike when we created a mock object for input we don't have to set the String for our mock.
We'll end up calling StringIO#puts on output and that is what will set the String value for our StringIO mock object.
Second, we have to alter the Transaction#prompt_for_payment method to accept a mock of our output.
This will work in a similar way to how we mocked the input.

We add a new parameter to Transaction#prompt_for_payment that will allow us to pass in an output mock object.
def prompt_for_payment(input: $stdin, output: $stdout)
Then, we use this output mock object within our method,
we call StringIO#puts and the string passed to puts gets stored within the StringIO object.
It isn't output to the user. Doing this should allow us to clean up our testing output that displays when running minitest.

Let's run the test again with our output mock:

Run options: --seed 45397

# Running:

.

Finished in 0.000912s, 1096.4154 runs/s, 1096.4154 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

There, now all we see is output related to the test itself.

---------
Student solutions: #altering $stdin/$stdout and resetting them to their constant afterwards

def test_prompt_for_payment
  $stdin = StringIO.new( '50' )
  $stdout = StringIO.new
  @transaction.prompt_for_payment
  assert_equal( 50, @transaction.amount_paid )
  $stdin = STDIN   # reset
  $stdout = STDOUT # reset
end

// # Same thing but with ensure clause

def test_prompt_for_payment
  io_in, $stdin = $stdin, StringIO.new("50\n", mode='r')
  io_out, $stdout = $stdout, StringIO.new(mode='w')
  @transaction.prompt_for_payment
  assert_equal(50, @transaction.amount_paid)
ensure
  $stdin, $stdout = io_in, io_out
end

// # Neat solution. Creating a sandwich code method that reassigns $stdout, yields to block, and resets $stdout again.

  def silenced
    $stdout = StringIO.new   # temporary reassignment to avoid output to screen
    yield
  ensure
    $stdout = STDOUT   # reset
  end

  def test_prompt_for_payment
    @transaction.amount_paid = 0
    io = StringIO.new('30')
    silenced do
      @transaction.prompt_for_payment(input: io)
    end
    assert_equal 30, @transaction.amount_paid
  end