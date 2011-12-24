require 'test/unit'

class MTest < Test::Unit::TestCase
  def m(arguments)
    `ruby -Ilib ./bin/m #{arguments}`.strip
  end
end
