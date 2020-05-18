Test swap method - Text

For this exercise you'll be given a sample text file and a starter class.
The sample text's contents will be saved as a String to an instance variable in the starter class.

The Text class includes a #swap method that can be used to replace all occurrences of one letter in the text with another letter.
And for this exercise we will swap all occurrences of 'a' with 'e'.

Your task is to write a test suite for class Text.
In that test suite write a test for the Text method swap.
For this exercise, you are required to use the minitest methods #setup and #teardown.
The #setup method contains code that will be executed before each test;
#teardown contains code that will be executed after each test.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed vulputate ipsum.
Suspendisse commodo sem arcu. Donec a nisi elit. Nullam eget nisi commodo, volutpat
quam a, viverra mauris. Nunc viverra sed massa a condimentum. Suspendisse ornare justo
nulla, sit amet mollis eros sollicitudin et. Etiam maximus molestie eros, sit amet dictum
dolor ornare bibendum. Morbi ut massa nec lorem tincidunt elementum vitae id magna. Cras
et varius mauris, at pharetra mi.

# Class and method to Test
class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end
end

-----------
Solution:

require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'text'

Minitest::Reporters.use!

class TextTest < Minitest::Test
  def setup
    @file = File.new('./sample_text.txt', 'r') # same as File.open when not given a block
    @file_swapped = File.new('./swapped_text.txt', 'r')
  end

  def test_swap_method
    sample_object = Text.new(@file.read)
    sample_string = sample_object.instance_variable_get(:@text)
    sample_swapped = sample_object.swap('a', 'e')

    assert_equal(sample_swapped, @file_swapped.read)
    assert_equal(sample_string.count('ae'), sample_swapped.count('e'))
    refute_includes(sample_swapped, 'a')
  end

  def teardown
    @file.close
    @file_swapped.close
  end
end

//
 # File#open automatically closes the file after running the attached block  (no need for teardown)
 # without a block, File#open is synonymous with File#new
  def setup
    File.open('./sample_text.txt', 'r') do |file| # NB this precludes further operations on the file
      @string_object = Text.new(file.read)
    end
  end

------
LS Solution & explanation:

Approach/Algorithm
To complete this exercise, you#'ll 
need to read the text from the sample text file.
Some of those file related operations are good candidates for execution in setup and teardown.
We want to put code in setup and teardown that may not be directly related to our tests, but is necessary for them to run properly.

Solution:
require 'minitest/autorun'
require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @file = File.open('./sample_text.txt', 'r')
  end

  def test_swap
    text = Text.new(@file.read)
    actual_text = text.swap('a', 'e')
    expected_text = <<~TEXT
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal expected_text, actual_text
  end

  def teardown
    @file.close
  end
end

Discussion:

To write this test we'll need to first create an instance of class Text.
Then, we need to pass it the text we want to work on.
To do that we'll have to read the text from the sample text file.

First, we must open the file for reading. We want to keep things directly related to our test in our test method.
So, any code that is necessary to setup the test is a perfect candidate for the #setup method.
We do so in our solution by opening the file in question and assigning the file object to an instance variable.

Once we have passed in the contents of that file to the Text class,
#we're 
ready to make the command that will lead to the assertion for this test.
That command is the call to Text#swap. In this case, the exercise asks us to use a and e as the letters to swap out.
The return value of this Text#swap method is what we will use to test that this method is working as intended.

Next, we need a String that we can test against the return value of Text#swap.
This will be our expected value for the later assertion.
To get this String, we just take the contents of the file and process it manually with our text editor to replace all of the a's with e's.

Finally, we use assert_equal to ensure that the expected value of the text is equal to the actual value.

---------
Student solutions:

# 1
When processing large files where we want to avoid loading the entire text to the memory,
we can do line by line processing (no setup and teardown though):

def test_swap
  IO.foreach('text.txt') do |line| # this method not available for StringIO class
    assert_equal(line.gsub('a', 'e'), Text.new(line).swap('a', 'e'))
  end
end

//

# 2
Storing the swapped text in a separate file and loading both files in the setup method and closing both in the teardown method:

class TextTest < Minitest::Test
  def setup
    @swapped_file = File.open('sample_swapped.txt', 'r') # good idea
    @sample_file = File.open('sample_text.txt', 'r')
    @text = Text.new(@sample_file.read)
  end

  def test_swap
    assert_equal(@swapped_file.read, @text.swap('a', 'e'))
  end

  def teardown
    @sample_file.close
    @swapped_file.close
  end
end

//

# 3
class TextTest < Minitest::Test
  def setup
    @text_file = File.open('sample_text.txt', 'r')
    @text_obj = Text.new(@text_file.read)
  end

  def test_swap
    # since there is no getter for @text, we can access @text by doing either:
    # text_before = @text_obj.instance_variable_get(:@text)     # <- option 1
    text_before = @text_obj.swap('', '')                        # <- option 2
    a_count = text_before.count('a')
    refute(a_count.zero?)
    e_count = text_before.count('e')
    a_e_total = a_count + e_count

    text_after = @text_obj.swap('a', 'e')
    assert_equal(0, text_after.count('a'))
    assert_equal(a_e_total, text_after.count('e'))
  end

  def teardown
    @text_file.close
  end
end