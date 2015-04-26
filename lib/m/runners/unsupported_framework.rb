module M
  module Runners
    class UnsupportedFramework
      def suites
        []
        not_supported
      end

      def not_supported
        STDERR.puts "This test framework is not supported! Please open up an issue at https://github.com/qrush/m !"
        false
      end
    end
  end
end
