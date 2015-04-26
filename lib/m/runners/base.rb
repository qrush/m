require_relative 'minitest_5'
require_relative 'minitest_4'
require_relative 'test_unit'
require_relative 'unsupported_framework'

### Runners are in charge of running your tests, depending on the framework
# Instead of slamming all of this junk in an `M` class, it's here instead.
module M
  module Runners
    class Base
      def initialize(argv, runner)
        @argv = argv
        @runner = runner
      end

      # There's two steps to running our tests:
      # 1. Parsing the given input for the tests we need to find (or groups of tests)
      # 2. Run those tests we found that match what you wanted
      def run
        parse
        execute
      end

      private

      def parse
        # With no arguments,
        if @argv.empty?
          # Just shell out to `rake test`.
          exec "rake test"
        else
          parse_options! @argv

          # Parse out ARGV, it should be coming in in a format like `test/test_file.rb:9`
          @file, line = @argv.first.split(':')
          @line ||= line.to_i

          # If this file is a directory, not a file, run the tests inside of this directory
          if Dir.exist?(@file)
            # Make a new rake test task with a hopefully unique name, and run every test looking file in it
            require "rake/testtask"
            Rake::TestTask.new(:m_custom) do |t|
              t.libs << 'test'
              t.libs << 'spec'
              t.test_files = FileList["#{@file}/*test*.rb", "#{@file}/*spec*.rb"]
            end
            # Invoke the rake task and exit, hopefully it'll work!
            Rake::Task['m_custom'].invoke
            exit
          end
        end
      end

      def parse_options!(argv)
        require 'optparse'

        OptionParser.new do |opts|
          opts.banner  = 'Options:'
          opts.version = M::VERSION

          opts.on '-h', '--help', 'Display this help.' do
            puts "Usage: m [OPTIONS] [FILES]\n\n", opts
            exit
          end

          opts.on '--version', 'Display the version.' do
            puts "m #{M::VERSION}"
            exit
          end

          opts.on '-l', '--line LINE', Integer, 'Line number for file.' do |line|
            @line = line
          end

          opts.parse! argv
        end
      end

      def execute
        # Locate tests to run that may be inside of this line. There could be more than one!
        tests_to_run = tests.within(@line)

        # If we found any tests,
        if tests_to_run.size > 0
          # assemble the regexp to run these tests,
          test_names = tests_to_run.map { |test| Regexp.escape(test.name) }.join('|')

          # set up the args needed for the runner
          test_arguments = ["-n", "/^(#{test_names})$/"]

          # directly run the tests from here and exit with the status of the tests passing or failing
          if Frameworks.minitest5?
            Minitest.run test_arguments
          elsif Frameworks.minitest4?
            MiniTest::Unit.runner.run test_arguments
          elsif defined?(Test)
            Test::Unit::AutoRunner.run(false, nil, test_arguments)
          else
            not_supported
          end
        elsif tests.size > 0
          # Otherwise we found no tests on this line, so you need to pick one.
          message = "No tests found on line #{@line}. Valid tests to run:\n\n"

          # For every test ordered by line number,
          # spit out the test name and line number where it starts,
          tests.by_line_number do |test|
            message << "#{sprintf("%0#{tests.column_size}s", test.name)}: m #{@file}:#{test.start_line}\n"
          end

          # Spit out helpful message and bail
          STDERR.puts message
          false
        else
          # There were no tests at all
          message = "There were no tests found.\n\n"
          STDERR.puts message
          false
        end
      end

      # Finds all test suites in this test file, with test methods included.
      def suites
        # Since we're not using `ruby -Itest -Ilib` to run the tests, we need to add this directory to the `LOAD_PATH`
        $:.unshift "./test", "./spec", "./lib"

        begin
          # Fire up this Ruby file. Let's hope it actually has tests.
          load @file
        rescue LoadError => e
          # Fail with a happier error message instead of spitting out a backtrace from this gem
          STDERR.puts "Failed loading test file:\n#{e.message}"
          return []
        end

        suites = @runner.suites

        # Use some janky internal APIs to group test methods by test suite.
        suites.inject({}) do |suites, suite_class|
          # End up with a hash of suite class name to an array of test methods, so we can later find them and ignore empty test suites
          if Frameworks.minitest5?
            suites[suite_class] = suite_class.runnable_methods if suite_class.runnable_methods.size > 0
          else
            suites[suite_class] = suite_class.test_methods if suite_class.test_methods.size > 0
          end
          suites
        end
      end

      # Shoves tests together in our custom container and collection classes.
      # Memoize it since it's unnecessary to do this more than one for a given file.
      def tests
        @tests ||= begin
                     require "m/test_collection"
                     require "m/test_method"
                     # With each suite and array of tests,
                     # and with each test method present in this test file,
                     # shove a new test method into this collection.
                     suites.inject(TestCollection.new) do |collection, (suite_class, test_methods)|
                       test_methods.each do |test_method|
                       collection << TestMethod.create(suite_class, test_method)
                     end
                     collection
                     end
                   end
      end

      # Fail loudly if this isn't supported
      def not_supported
        STDERR.puts "This test framework is not supported! Please open up an issue at https://github.com/qrush/m !"
        false
      end
    end
  end
end
