require 'test_helper'

class RunByLineNumberTest < MTest
  def test_run_simple_test_by_line_number
    output = m('test/example_test.rb:7')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_runs_entire_test_without_line_number
    output = m('test/example_test.rb')
    assert_output /2 tests/, output
  end

  def test_run_inside_of_test
    output = m('test/example_test.rb:8')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_run_on_end_of_test
    output = m('test/example_test.rb:9')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_run_inside_big_test
    output = m('test/example_test.rb:14')
    assert_output /1 tests, 3 assertions/, output
  end
end
