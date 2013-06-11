require 'test/unit'
require 'active_support/test_case'

class ActiveSupportExampleTest < ActiveSupport::TestCase
  setup do
  end

  test "#assert_equal compares to objects (and ensures they are equal)" do
    assert_equal 1, 1
  end
end
