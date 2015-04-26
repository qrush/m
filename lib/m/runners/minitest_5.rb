module M
  module Runners
    class Minitest5
      def suites
        Minitest::Runnable.runnables
      end
    end
  end
end
