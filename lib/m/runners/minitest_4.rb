module M
  module Runners
    class Minitest4
      def suites
        MiniTest::Unit::TestCase.test_suites
      end
    end
  end
end
