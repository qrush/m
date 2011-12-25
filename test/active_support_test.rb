require 'test_helper'

class ActiveSupportTestCase < ActiveSupport::TestCase
  setup do
  end

  test "carrot" do
    assert_equal 1, 1
  end

  test "daikon" do
    assert_equal 1, 1
    assert_equal 2, 2
    assert_equal 3, 3
  end

  test "eggplant fig" do
    assert_equal 4, 4
  end
end
