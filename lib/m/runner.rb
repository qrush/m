require_relative "parser"
require_relative "executor"

### Runners are in charge of running your tests, depending on the framework
# Instead of slamming all of this junk in an `M` class, it's here instead.
module M
  class Runner
    def initialize argv
      @argv = argv
    end

    # There's two steps to running our tests:
    # 1. Parsing the given input for the tests we need to find (or groups of tests)
    # 2. Run those tests we found that match what you wanted
    def run
      testable = Parser.new(@argv).parse
      Executor.new(testable).execute
    end
  end
end
