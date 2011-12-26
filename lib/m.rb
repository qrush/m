require "ruby_parser"
require "sourcify"

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
        tests.each do |method_name, (start_line, end_line)|
          if @line >= start_line && @line <= end_line
            run_tests method_name
          end
        end

        message = "No tests found on line #{@line}. Valid tests to run:\n\n"
        column_size = tests.keys.map { |method_name| method_name.to_s.size }.max
        tests.sort_by { |test| test.last.first }.each do |method_name, (start_line, end_line)|
          message << "#{sprintf("%0#{column_size}s", method_name)}: m #{@file}:#{start_line}\n"
        end
        abort message
      end
    end

    private

    def tests
      @tests ||= begin
        $:.unshift "./test"
        load @file
        suites = Test::Unit::TestCase.test_suites.inject({}) do |suites, suite_class|
          suites[suite_class] = suite_class.test_methods unless suite_class.test_methods.empty?
          suites
        end
        tests = suites.map do |suite_class, test_methods|
          suite = suite_class.new(//)
          test_methods.map do |test_method|
            method     = suite.method(test_method)
            start_line = method.source_location.last
            end_line   = method.to_source.split("\n").size + start_line - 1
            [test_method, [start_line, end_line]]
          end
        end
        Hash[*tests]
      end
    end

    def run_tests(method_name = nil)
      command = "ruby -Itest #{@file}"
      command << " -n '/#{method_name}/'" if method_name
      exec command
    end
  end

  def self.run(argv)
    Runner.new(argv).run
  end
end
