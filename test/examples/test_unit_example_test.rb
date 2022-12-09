require_relative "../test_helper"
try_loading "test-unit"

if M::Frameworks.test_unit?
  class TestUnitExampleTest < Test::Unit::TestCase
    def setup
    end

    def test_apple
      assert_equal 1, 1
    end

    def test_banana
      assert_equal 1, 1
      assert_equal 2, 2
      assert_equal 3, 3
    end
  end
end
