require "test_helper"

if M::Frameworks.minitest4?
  class Minitest4Test < MTest
    def test_run_simple_test_by_line_number
      output = m "examples/minitest_4_example_test.rb:19"
      assert_output(/1 tests, 1 assertions/, output)
    end

    def test_runs_entire_test_without_line_number
      output = m "examples/minitest_4_example_test.rb"
      assert_output(/3 tests/, output)
    end

    def test_run_inside_of_test
      output = m "examples/minitest_4_example_test.rb:20"
      assert_output(/1 tests, 1 assertions/, output)
    end

    def test_run_on_end_of_test
      output = m "examples/minitest_4_example_test.rb:21"
      assert_output(/1 tests, 1 assertions/, output)
    end

    def test_run_inside_big_test
      output = m "examples/minitest_4_example_test.rb:26"
      assert_output(/1 tests, 6 assertions/, output)
    end

    def test_run_on_blank_line
      output = m "examples/minitest_4_example_test.rb:2"

      assert !$?.success?
      assert_match(/No tests found on line 2. Valid tests to run:/, output)
      assert_match %r{    test_that_kitty_can_eat: m examples/minitest_4_example_test\.rb:19}, output
      assert_match %r{test_that_it_will_not_blend: m examples/minitest_4_example_test\.rb:23}, output
    end
  end
end
