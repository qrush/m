require "active_support"
require "active_support/test_case"

class ActiveSupportExampleTest < ActiveSupport::TestCase
  test "#assert_equal compares to objects (and ensures they are equal)" do
    assert_equal 1, 1
  end
end
