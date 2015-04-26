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
end
