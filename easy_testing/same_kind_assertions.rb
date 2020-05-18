Same Object Assertions
Write a unit test that will fail if list and the return value of list.process are different objects.

assert_same(list, list.process)
//
assert(list.equal?(list.process))
//
assert(list.object_id == list.process.object_id)

//

class TestClass < Minitest::Test
  def test_same
    list = [9,4,1]
    list.define_singleton_method(:process) { self }
    assert_same(list, list.process)
    assert(list.equal?(list.process))
    assert(list.object_id == list.process.object_id)
  end
end

Discussion:
#assert_same tests whether its first and second arguments are the same object, as determined by #equal?.




