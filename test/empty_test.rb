require "test_helper"

class EmptyTest < MTest
  def test_run_simple_test_by_line_number
    output = m "examples/empty_example_test.rb"
    assert !$?.success?
    assert_match(/There were no tests found./, output)
  end
end
