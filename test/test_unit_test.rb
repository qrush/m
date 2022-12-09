require "test_helper"

if M::Frameworks.test_unit?
  class TestUnitTest < MTest
    def test_run_simple_test_by_line_number
      output = m "examples/test_unit_example_test.rb:9"
      assert_output(/1 tests, 1 assertions/, output)
    end

    def test_runs_entire_test_without_line_number
      output = m "examples/test_unit_example_test.rb"
      assert_output(/2 tests/, output)
    end

    def test_run_inside_of_test
      output = m "examples/test_unit_example_test.rb:10"
      assert_output(/1 tests, 1 assertions/, output)
    end

    def test_run_on_end_of_test
      output = m "examples/test_unit_example_test.rb:11"
      assert_output(/1 tests, 1 assertions/, output)
    end

    def test_run_inside_big_test
      output = m "examples/test_unit_example_test.rb:15"
      assert_output(/1 tests, 3 assertions/, output)
    end

    def test_run_on_blank_line
      output = m "examples/test_unit_example_test.rb:8"

      assert !$?.success?
      assert_match(/No tests found on line 8. Valid tests to run:/, output)
      assert_match %r{ test_apple: m examples/test_unit_example_test\.rb:9}, output
      assert_match %r{test_banana: m examples/test_unit_example_test\.rb:13}, output
    end
  end
end
