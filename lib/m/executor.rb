require_relative "runners/base"
require_relative "runners/minitest_5"
require_relative "runners/minitest_4"
require_relative "runners/test_unit"
require_relative "runners/unsupported_framework"

module M
  class Executor
    def initialize testable
      @testable = testable
    end

    def execute
      # Locate tests to run that may be inside of this line. There could be more than one!
      tests_to_run = tests.within testable.lines

      # If we found any tests,
      if tests_to_run.size.positive?
        # assemble the regexp to run these tests,
        test_names = tests_to_run.map { |test| Regexp.escape(test.name) }.join("|")

        # set up the args needed for the runner
        test_arguments = ["-n", "/^(#{test_names})$/"]

        # directly run the tests from here and exit with the status of the tests passing or failing
        runner.run test_arguments + testable.passthrough_options
      elsif tests.size.positive?
        # Otherwise we found no tests on this line, so you need to pick one.
        message = "No tests found on line #{testable.lines.join ", "}. Valid tests to run:\n\n"

        # For every test ordered by line number,
        # spit out the test name and line number where it starts,
        tests.by_line_number do |test|
          message << "#{format "%0#{tests.column_size}s", test.name}: m #{testable.file}:#{test.start_line}\n"
        end

        # Spit out helpful message and bail
        warn message
        false
      else
        # There were no tests at all
        message = "There were no tests found.\n\n"
        warn message
        false
      end
    end

    private

    attr_reader :testable

    # Shoves tests together in our custom container and collection classes.
    # Memoize it since it's unnecessary to do this more than one for a given file.
    def tests
      @tests ||= begin
        require "m/test_collection"
        require "m/test_method"
        # With each suite and array of tests,
        # and with each test method present in this test file,
        # shove a new test method into this collection.
        suites.each_with_object TestCollection.new do |(suite_class, test_methods), collection|
          test_methods.each do |test_method|
            collection << TestMethod.create(suite_class, test_method)
          end
        end
      end
    end

    # Finds all test suites in this test file, with test methods included.
    def suites
      # Since we're not using `ruby -Itest -Ilib` to run the tests, we need to add this directory to the `LOAD_PATH`
      $LOAD_PATH.unshift "./test", "./spec", "./lib"

      begin
        # Fire up this Ruby file. Let's hope it actually has tests.
        require "./#{testable.file}"
      rescue LoadError => e
        # Fail with a happier error message instead of spitting out a backtrace from this gem
        warn "Failed loading test file:\n#{e.message}"
        return []
      end

      suites = runner.suites

      # Use some janky internal APIs to group test methods by test suite.
      suites.each_with_object({}) do |suite_class, test_suites|
        # End up with a hash of suite class name to an array of test methods, so we can later find them and ignore empty test suites
        test_suites[suite_class] = runner.test_methods(suite_class) if runner.test_methods(suite_class).any?
      end
    end

    def runner
      @runner ||= M::Frameworks.framework_runner
    end
  end
end
