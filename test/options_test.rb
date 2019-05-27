require 'test_helper'

class OptionsTest < MTest
  def test_short_help_option
    output = m('-h')
    assert_output(/^Usage: m \[OPTIONS\] \[FILES\]/, output)
  end

  def test_long_help_option
    output = m('--help')
    assert_output(/^Usage: m \[OPTIONS\] \[FILES\]/, output)
  end

  def test_verbose_option
    output = m('--version')
    assert_output(/^m #{M::VERSION}/, output)
  end

  def test_short_line_option
    output = m('-l20 examples/minitest_4_example_test.rb')
    assert_output(/1 tests, 1 assertions/, output)
  end

  def test_long_line_option
    output = m('--line 20 examples/minitest_4_example_test.rb')
    assert_output(/1 tests, 1 assertions/, output)
  end

  def test_line_option_has_precedence_over_colon_format
    output = m('--line 20 examples/minitest_4_example_test.rb:2')
    assert_output(/1 tests, 1 assertions/, output)
  end

  def test_recursive_option
    output = m('-r examples/subdir')
    assert_output(/5 tests/, output)
  end

  def test_recursive_option_without_directory_arg_fails
    output = m('-r')
    assert_match(/OptionParser::MissingArgument/, output)
  end

  def test_passthrough_options
    output = m('-- --verbose')
    assert_output(/0 errors/, output)
  end

  def test_passthrough_options_with_file
    output = m('examples/minitest_4_example_test.rb -- --verbose')
    assert_output(/3 tests, 9 assertions/, output)
  end

  def test_passthrough_options_with_file_and_other_options
    output = m('--line 20 examples/minitest_4_example_test.rb -- --verbose')
    assert_output(/1 tests, 1 assertions/, output)
  end
end
