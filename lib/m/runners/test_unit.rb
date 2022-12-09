module M
  module Runners
    class TestUnit < Base
      def suites
        if Test::Unit::TestCase.respond_to? :test_suites
          Test::Unit::TestCase.test_suites
        else
          Test::Unit::TestCase::DESCENDANTS
        end
      end

      def run test_arguments
        Test::Unit::AutoRunner.run false, nil, test_arguments
      end

      def test_methods suite_class
        if suite_class.respond_to? :test_methods
          suite_class.test_methods
        else
          suite_class.public_instance_methods(true).grep(/^test/).map(&:to_s)
        end
      end
    end
  end
end
