require "active_support"
require "active_support/test_case"

class MultipleExampleTest < ActiveSupport::TestCase
  ["grape", "habanero", "iceplant"].each do |fruit|
    test "#{fruit} is a fruit" do
      assert_equal 1, 1
    end
  end

  def test_normal
    assert_equal 1, 1
  end
end
