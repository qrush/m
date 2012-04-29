require 'active_support/inflector'

module M
  class Framework
    def test_suites
      test_case.test_suites
    end

    def test_case
      framework.test_case
    end

    def framework
      if defined?(Test)
        TestUnitDecorator.new
      elsif defined?(MiniTest)
        MiniTestDecorator.new
      else
        not_supported
      end
    end

    def run(test_arguments)
      framework.run(test_arguments)
    end

    # Fail loudly if this isn't supported
    def not_supported
      abort "This test framework is not supported! Please open up an issue at https://github.com/qrush/m !"
    end

    class Decorator
      attr_reader :klass

      def run(test_arguments)
        runner.run(test_arguments)
      end

      def runner
        raise NotImplementedError
      end

      def test_case
        "#{klass}::TestCase".constantize
      end
    end

    class MiniTestDecorator < Decorator
      def initialize
        @klass = MiniTest::Unit
      end

      def runner
        klass.runner
      end
    end

    class TestUnitDecorator < Decorator
      def initialize
        @klass = Test::Unit
      end

      def run(test_arguments)
        runner.run(false, nil, test_arguments)
      end

      def runner
        "#{klass}::AutoRunner".constantize
      end
    end
  end
end
