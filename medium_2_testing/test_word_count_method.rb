Test word_count method - Text

Recall that in the last exercise we only had to test one method of our Text class.
One of the useful facets of the setup and teardown methods is 
that they are automatically run before and after each test respectively.
To show this we will be adding one more method to our Text class, word_count.

class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end

  def word_count
    @text.split.count
  end
end
Write a test for this new method. Make sure to utilize the setup and teardown methods for any file related operations.

-------

require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'text'

Minitest::Reporters.use!

class TextTest < Minitest::Test
  def setup
    @file = File.new('./sample_text.txt', 'r')
    @file_string = @file.read      # @file_object needs a #rewind command before it can be read again
    @text_object = Text.new(@file_string)
  end

  def test_swap_method
    word_count = @file_string.split.count
    assert_equal(word_count, @text_object.word_count)
  end

  def teardown
    @file.close
  end
end

--------
LS Solution: more brief, with added #teardown code

require 'minitest/autorun'
require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @file = File.open('./sample_text.txt', 'r')
  end

  # omitted for brevity

  def test_word_count
    text = Text.new(@file.read)
    assert_equal 72, text.word_count
  end

  def teardown
    @file.close
    puts "File has been closed: #{@file.closed?}"
  end
end

Discussion:

For this test we first need to determine the word count of the sample text.
That can be ascertained easily enough by calling the word_count method manually,
or by reading in the file in irb and counting the words from there.

We then write in that value into our test as the expected value.
We also need to make sure that we read the file to gain access to the relevant text.
We're able to call @file.read since the opening of our file is handled in the setup method.
If we didn't first open that file, then calling @file.read would throw an error.
Lastly, we use assert_equal with our hard-coded word count and a call to text.word_count as arguments.

Regarding our teardown method, Ruby can be a bit lenient when it comes to closing files.
If we didn't call @file.close, then the File object associated with @file would be closed when our script is finished running.
This is a failsafe implemented by the IO class. But it is best to be explicit about these things.
Since this is an example where we only work with one file, things may turn out ok.

But imagine if we were dealing with several files, we would want to keep track of when they are opened and closed.
It may not seem all that intuitive that our File really is closed properly.
We could add one more line of code to our test file to verify that teardown is called after each test.
We'll use the predicate method, closed? to verify that we have closed our file.

--------------
Student solution:

class TextTest < Minitest::Test
  def setup
    @text_file = File.open('sample_text.txt', 'r')
    @text_obj = Text.new(@text_file.read)
  end

  def test_word_count
    expected_word_count = @text_obj.swap('', '').scan(/\w+/).size
    actual_word_count = @text_obj.word_count
    assert_equal(expected_word_count, actual_word_count)
  end

  # omitted...
end