module M
  module Runners
    class TestUnit < Base
      def suites
        Test::Unit::TestCase.test_suites
      end

      def run(test_arguments)
        Test::Unit::AutoRunner.run(false, nil, test_arguments)
      end
    end
  end
end
