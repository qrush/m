require 'test/unit'
require 'active_support/test_case'

class MTest < Test::Unit::TestCase
  def m(arguments)
    Dir.chdir("test") do
      `ruby -I../lib -I. ../bin/m #{arguments} 2>&1`.strip
    end
  end

  def assert_output(regexp, output)
    assert $?.success?, "Execution failed, output:\n\n#{output}"
    assert_match regexp, output
  end
end
