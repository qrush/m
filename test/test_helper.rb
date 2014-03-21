if ENV['TRAVIS']
  require 'coveralls'

  Coveralls.wear!
end

module Testable
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

require './lib/m'
require 'minitest/autorun'
if M::Frameworks.minitest5?
  class MTest < Minitest::Test
    include ::Testable
  end
else
  require 'test/unit'
  require 'active_support/test_case'

  class MTest < Test::Unit::TestCase
    include ::Testable
  end
end
