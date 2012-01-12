require 'test_helper'

class EverythingTest < MTest
  def test_runs_entire_test_suite_with_no_arguments
    output = m('')
    assert_output /10 tests/, output
  end

  def test_missing_file_gives_a_decent_error_message
    output = m('examples/thisdoesnexist_test.rb')
    assert !$?.success?
    assert_match /Failed loading test file/, output
    assert_match /cannot load such file/, output
  end
end
