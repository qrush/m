require 'test_helper'

class ActiveSupportTest < MTest
  def test_run_simple_test_by_line_number
    output = m('test/examples/active_support_example_test.rb:11')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_runs_entire_test_without_line_number
    output = m('test/examples/active_support_example_test.rb')
    assert_output /4 tests/, output
  end

  def test_run_inside_of_test
    output = m('test/examples/active_support_example_test.rb:12')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_run_on_end_of_test
    output = m('test/examples/active_support_example_test.rb:13')
    assert_output /1 tests, 1 assertions/, output
  end

  def test_run_inside_big_test
    output = m('test/examples/active_support_example_test.rb:17')
    assert_output /1 tests, 3 assertions/, output
  end

  def test_run_on_blank_line_orders_tests_by_line_number
    output = m('test/examples/active_support_example_test.rb:2')

    assert !$?.success?
    expected = <<-EOF
No tests found on line 2. Valid tests to run:

      test_normal: m test/examples/active_support_example_test.rb:7
      test_carrot: m test/examples/active_support_example_test.rb:11
      test_daikon: m test/examples/active_support_example_test.rb:15
test_eggplant_fig: m test/examples/active_support_example_test.rb:21
EOF
    assert_equal expected.strip, output
  end

  def test_run_on_test_with_spaces
    output = m('test/examples/active_support_example_test.rb:21')
    assert_output /1 tests, 1 assertions/, output
  end
end
