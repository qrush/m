module M
  module Runners
    class UnsupportedFramework < Base
      def suites
        not_supported
        []
      end

      def run _test_arguments
        not_supported
      end

      private

      def not_supported
        warn "This test framework is not supported! Please open up an issue at https://github.com/qrush/m !"
        false
      end
    end
  end
end
