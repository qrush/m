module M
  module Runners
    class Base
      def suites
        raise "Not implemented"
      end

      def run _test_arguments
        raise "Not implemented"
      end

      def test_methods suite_class
        suite_class.test_methods
      end
    end
  end
end
