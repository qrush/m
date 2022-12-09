require "test_helper"

class ActiveSupportTest < MTest
  def test_run_simple_test_by_line_number
    output = m "examples/active_support_example_test.rb:9"
    assert_output(/1 (runs|tests), 1 assertions/, output)
  end

  def test_runs_entire_test_without_line_number
    output = m "examples/active_support_example_test.rb"
    assert_output(/4 (runs|tests)/, output)
  end

  def test_run_inside_of_test
    output = m "examples/active_support_example_test.rb:10"
    assert_output(/1 (runs|tests), 1 assertions/, output)
  end

  def test_run_on_end_of_test
    output = m "examples/active_support_example_test.rb:11"
    assert_output(/1 (runs|tests), 1 assertions/, output)
  end

  def test_run_inside_big_test
    output = m "examples/active_support_example_test.rb:15"
    assert_output(/1 (runs|tests), 3 assertions/, output)
  end

  def test_run_on_blank_line_orders_tests_by_line_number
    output = m "examples/active_support_example_test.rb:8"

    assert !$?.success?
    expected = <<~OUTPUT
      No tests found on line 8. Valid tests to run:

            test_normal: m examples/active_support_example_test.rb:5
            test_carrot: m examples/active_support_example_test.rb:9
            test_daikon: m examples/active_support_example_test.rb:13
      test_eggplant_fig: m examples/active_support_example_test.rb:19
    OUTPUT
    assert_equal expected.strip, output
  end

  def test_run_on_test_with_spaces
    output = m "examples/active_support_example_test.rb:19"
    assert_output(/1 (runs|tests), 1 assertions/, output)
  end

  def test_run_on_test_with_unescaped_regular_express_characters
    output = m "examples/active_support_unescaped_example_test.rb:5"
    assert_output(/1 (runs|tests), 1 assertions/, output)
  end
end
