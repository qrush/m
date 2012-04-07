require 'test_helper'

class OptionsTest < MTest
  def test_short_help_option
    output = m('-h')
    assert_output /^Usage: m \[OPTIONS\] \[FILES\]/, output
  end

  def test_long_help_option
    output = m('--help')
    assert_output /^Usage: m \[OPTIONS\] \[FILES\]/, output
  end

  def test_verbose_option
    output = m('--version')
    assert_output /^m #{M::VERSION}/, output
  end
end
