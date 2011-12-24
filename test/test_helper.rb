require 'test/unit'

class MTest < Test::Unit::TestCase
  def m(arguments)
    `ruby -Ilib ./bin/m #{arguments}`.strip
  end

  def assert_output(regexp, output)
    assert $?.success?, "Execution failed, output:\n\n#{output}"
    assert_match regexp, output
  end
end
