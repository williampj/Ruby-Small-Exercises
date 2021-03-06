Refutations

Write a unit test that will fail if 'xyz' is one of the elements in the Array list:

-----
Solution:

refute_includes(list, 'xyz')

//

class TestClass < Minitest::Test
  def test_refute_includes
    list = ['xyze', 'aaa']
    refute_includes(list, 'xyz')
  end
end

Discussion:

Most of the minitest assertions have a corresponding refute method that fails if the indicated condition is true:
refute_equal is the opposite of assert_equal,
refute_kind_of is the opposite of assert_kind_of, etc.
So, the refutation of assert_includes is refute_includes.