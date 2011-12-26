require 'test_helper'

class MultipleExampleTest < ActiveSupport::TestCase
  %w(grape habanero iceplant).each do |fruit|
    test "#{fruit} is a fruit" do
      assert_equal 1, 1
    end
  end

  def test_normal
    assert_equal 1, 1
  end
end
