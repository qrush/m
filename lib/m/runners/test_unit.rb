module M
  module Runners
    class TestUnit
      def suites
        Test::Unit::TestCase.test_suites
      end
    end
  end
end
