module M
  module Runners
    class Minitest5
      def suites
        Minitest::Runnable.runnables
      end

      def run(test_arguments)
        Minitest.run test_arguments
      end
    end
  end
end
