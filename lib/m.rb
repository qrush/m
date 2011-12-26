require "ostruct"

require "ruby_parser"
require "sourcify"

require "m/test"
require "m/version"

module M
  class Runner
    def initialize(argv)
      @file, line = argv.first.split(':')
      @line = line.to_i
    end

    def run
      if @line.zero?
        run_tests
      else
        # collection of tests:
        # what tests are within this range of lines?
        # what is the size of the longest test case?
        # tests sorted by start number
        #
        # test class:
        # #start_line
        # #end_line
        # #name

        tests_to_run = tests.select do |test|
          (test.start_line..test.end_line).include? @line
        end

        if tests_to_run.size > 0
          run_tests(tests_to_run)
        else
          message = "No tests found on line #{@line}. Valid tests to run:\n\n"
          column_size = tests.map { |test| test.name.to_s.size }.max
          tests.sort_by(&:start_line).each do |test|
            message << "#{sprintf("%0#{column_size}s", test.name)}: m #{@file}:#{test.start_line}\n"
          end
          abort message
        end
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
        suites.map do |suite_class, test_methods|
          suite = suite_class.new(//)
          test_methods.map do |test_method|
            method     = suite.method(test_method)
            start_line = method.source_location.last
            end_line   = method.to_source.split("\n").size + start_line - 1

            M::Test.new(test_method, start_line, end_line)
          end
        end.flatten
      end
    end

    def run_tests(tests_to_run = [])
      method_names = tests_to_run.map(&:name)

      if method_names.empty?
        exec "ruby -Itest #{@file}"
      else
        exit ::Test::Unit::AutoRunner.run(false, nil, ["-n", "/(#{method_names.join('|')})/"])
      end
    end
  end

  def self.run(argv)
    Runner.new(argv).run
  end
end
