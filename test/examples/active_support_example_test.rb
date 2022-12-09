require "active_support"
require "active_support/test_case"

class ActiveSupportExampleTest < ActiveSupport::TestCase
  def test_normal
    assert_equal 1, 1
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
