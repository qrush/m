require "test_helper"

class ExitCodesTest < MTest
  def test_failing_test_returns_1
    m "examples/subdir_with_failures/a_test"
    refute $?.success?, "expected exit code to be 1 but it was #{$?.exitstatus}"
  end

  def test_test_with_error_returns_1
    m "../lib/error_tests/error_test"
    refute $?.success?, "expected exit code to be 1 but it was #{$?.exitstatus}"
  end

  def test_dir_with_failure_returns_1
    m "examples/subdir_with_failures"
    refute $?.success?, "expected exit code to be 1 but it was #{$?.exitstatus}"
  end

  def test_dir_with_error_returns_1
    m "../lib/error_tests"
    refute $?.success?, "expected exit code to be 1 but it was #{$?.exitstatus}"
  end

  def test_without_errors_or_failures_returns_0
    m "examples/subdir/a_test"
    assert $?.success?, "expected exit code to be 0 but it was #{$?.exitstatus}"
  end

  def test_dir_without_errors_or_failures_returns_0
    m "examples/subdir"
    assert $?.success?, "expected exit code to be 0 but it was #{$?.exitstatus}"
  end
end
