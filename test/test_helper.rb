require 'test/unit'
require 'active_support/test_case'

class MTest < Test::Unit::TestCase
  def m(arguments)
    `ruby -Ilib ./bin/m #{arguments} 2>&1`.strip
  end

  def assert_output(regexp, output)
    assert $?.success?, "Execution failed, output:\n\n#{output}"
    assert_match regexp, output
  end
end
