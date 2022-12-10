module M
  module Runners
    class Minitest4 < Base
      def suites
        MiniTest::Unit::TestCase.test_suites
      end

      def run test_arguments
        MiniTest::Unit.runner.run test_arguments
      end
    end
  end
end
