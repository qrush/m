require 'test_helper'

class RunByLineNumberTest < MTest
  def test_run_simple_test_by_line_number
    output = m('test/example_test.rb:4')

    assert $?.success?, "Execution failed, output:\n\n#{output}"
    assert_match /1 tests, 1 assertions/, output
  end

  def test_runs_entire_test_without_line_number
    output = m('test/example_test.rb')

    assert $?.success?, "Execution failed, output:\n\n#{output}"
    assert_match /2 tests, 2 assertions/, output
  end
end
