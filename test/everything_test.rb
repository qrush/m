require "test_helper"

class EverythingTest < MTest
  def test_runs_entire_test_suite_with_no_arguments
    output = m ""
    assert_output(/12 (runs|tests)/, output)
  end

  def test_missing_file_gives_a_decent_error_message
    output = m "examples/thisdoesnexist_test.rb"
    assert !$?.success?
    assert_match(/Failed loading test file/, output)
    if defined? JRUBY_VERSION
      assert_match(/no such file to load/, output)
    else
      assert_match(/cannot load such file/, output)
    end
  end

  def test_running_tests_within_a_subdirectory
    output = m "examples/subdir"
    assert_output(/3 (runs|tests)/, output)

    output = m "examples"
    assert_output(/12 (runs|tests)/, output)
  end

  def test_running_tests_with_failures_within_a_subdirectory
    output = m "examples/subdir_with_failures"
    assert_output_for_failed_execution(/1 (runs|tests), 1 assertions, 1 failures/, output)
  end

  def test_blank_file_is_quieter
    output = m "bananas"
    assert(/Valid tests to run/ !~ output)
  end
end
