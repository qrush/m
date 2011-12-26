require "forwardable"
require "ostruct"

require "ruby_parser"
require "sourcify"

require "m/test"
require "m/test_collection"
require "m/version"

module M
  class Runner
    def initialize(argv)
      @file, line = argv.first.split(':')
      @line = line.to_i
    end

    def run
      tests_to_run = tests.within(@line)

      if tests_to_run.size > 0
        run_tests(tests_to_run)
      else
        message = "No tests found on line #{@line}. Valid tests to run:\n\n"
        tests.by_line_number do |test|
          message << "#{sprintf("%0#{tests.column_size}s", test.name)}: m #{@file}:#{test.start_line}\n"
        end
        abort message
      end
    end

    private

    def tests
      @tests ||= begin
        $:.unshift "./test"
        load @file
        suites = ::Test::Unit::TestCase.test_suites.inject({}) do |suites, suite_class|
          suites[suite_class] = suite_class.test_methods unless suite_class.test_methods.empty?
          suites
        end
        collection = M::TestCollection.new
        suites.each do |suite_class, test_methods|
          suite = suite_class.new(//)
          test_methods.each do |test_method|
            collection << M::Test.new_from_object_and_method(suite, test_method)
          end
        end
        collection
      end
    end

    def run_tests(collection)
      test_names = collection.map(&:name).join('|')
      exit ::Test::Unit::AutoRunner.run(false, nil, ["-n", "/(#{test_names})/"])
    end
  end

  def self.run(argv)
    Runner.new(argv).run
  end
end
