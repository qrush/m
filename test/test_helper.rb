begin
  require "coveralls"
  Coveralls.wear_merged!
rescue LoadError
  warn "gem 'coveralls' not available, proceeding without it"
end

module Testable
  def m arguments
    Dir.chdir "test" do
      `ruby -I../lib  -I. ../bin/m #{arguments} 2>&1`.strip
    end
  end

  def assert_output regexp, output
    assert $?.success?, "Execution failed, output:\n\n#{output}"
    assert_match regexp, output
  end

  def assert_output_for_failed_execution regexp, output
    refute $?.success?, "Execution did not fail, but it should"
    assert_match regexp, output
  end
end

require "m"

def try_loading gem
  require gem
rescue LoadError
  false
end

try_loading("test-unit") ||
  try_loading("minitest/autorun") ||
  try_loading("test/unit")

if M::Frameworks.test_unit?
  begin
    require "test-unit"
  rescue LoadError
    require "active_support/test_case"
  end

  class MTest < Test::Unit::TestCase
    include ::Testable
  end
elsif M::Frameworks.minitest5?
  class MTest < Minitest::Test
    include ::Testable
  end
else
  class MTest < MiniTest::Unit::TestCase
    include ::Testable
  end
end
