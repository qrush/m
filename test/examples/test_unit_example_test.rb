if Bundler.definition.current_dependencies.map(&:name).include?("test-unit")
  require 'test-unit'
end
require 'test/unit'

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
