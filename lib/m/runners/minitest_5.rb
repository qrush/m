module M
  module Runners
    class Minitest5 < Base
      def suites
        Minitest::Runnable.runnables
      end

      def run(test_arguments)
        Minitest.run test_arguments
      end

      def test_methods(suite_class)
        suite_class.runnable_methods
      end
    end
  end
end
