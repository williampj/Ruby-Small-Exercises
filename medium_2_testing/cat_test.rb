# require 'minitest/reporters'
require 'minitest/autorun'
# Minitest::Reporters.use!
require_relative 'cat'

class CatTest < MiniTest::Test
  def setup
    @kitty = Cat.new('Kitty', 4)
  end

  # def test_is_cat; end

  # def test_name
    # assert_equal(@kitty.name, 'Milo')
    # assert_equal('Milo', @kitty.name)
    # assert(@kitty.name == 'Milo')
    # refute_equal('Kitty', @kitty.name)
  # end

#   def test_miaow
#     skip
#     # assert(@kitty.miaow.include?(' is miaowing.'))
#     # assert_includes(@kitty.miaow, ' is miaowing.')
#     # # assert_equal(' is miaowing.', @kitty.miaow)
#     # # assert_includes(' is miaowing.', @kitty.miaow)?
#     # assert_includes(@kitty.miaow, ' is miaowing.')
#     # assert_match(/\sis\smiaowing\./, @kitty.miaow)
#   end
# # You want to test that calling the #miaow method on the @kitty instance will return the string containing' is miaowing.';
# # which of the following code snippets could you place in the body of the test_miaow test?

#   def test_raises_error
#     assert_raises do
#       Cat.new
#     end

#   #   # assert_raises(ArgumentError) do
#   #   #   Cat.new("Milo")
#   #   # end

#   #   assert_raises(StandardError) do
#   #     Cat.new
#   #   end

#     # assert(Cat.new == ArgumentError)
#     # assert_raises(ArgumentError) {Cat.new}
#   end

  def test_is_not_purrier
    patch = Cat.new('Patch', 5)
    milo = Cat.new('Milo', 3)
    refute(patch.purr_factor > milo.purr_factor)
  end
end