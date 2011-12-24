require 'test_helper'

class RunActiveSupportTest < MTest
  def test_run_simple_test_by_line_number
    output = m('test/active_support_test.rb:7')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_runs_entire_test_without_line_number
    output = m('test/active_support_test.rb')
    assert_output /2 tests/, output
  end

  def test_run_inside_of_test
    output = m('test/active_support_test.rb:8')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_run_on_end_of_test
    output = m('test/active_support_test.rb:9')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_run_inside_big_test
    output = m('test/active_support_test.rb:14')
    assert_output /1 tests, 3 assertions/, output
  end

  def test_run_on_blank_line
    output = m('test/active_support_test.rb:2')

    assert !$?.success?
    assert_match /No tests found on line 2. Valid tests to run:/, output
    assert_match %r{test_carrot: m test/active_support_test\.rb:7}, output
    assert_match %r{test_daikon: m test/active_support_test\.rb:11}, output
  end
end
