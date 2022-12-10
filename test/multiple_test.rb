require "test_helper"

class MultipleTest < MTest
  def test_run_simple_test_by_line_number
    output = m "examples/multiple_example_test.rb:11"
    assert_output(/1 (runs|tests), 1 assertions/, output)
  end

  def test_runs_entire_test_without_line_number
    output = m "examples/multiple_example_test.rb"
    assert_output(/4 (runs|tests)/, output)
  end

  def test_runs_all_tests_on_given_line_number
    output = m "examples/multiple_example_test.rb:6"
    assert_output(/3 (runs|tests)/, output)
  end
end
