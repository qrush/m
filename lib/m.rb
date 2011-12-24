require "ruby_parser"

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
        tests.each do |method_name, (start_line, end_line)|
          message << "#{sprintf("%0#{column_size}s", method_name)}: m #{@file}:#{start_line}\n"
        end
        abort message
      end
    end

    private

    def tests
      @tests ||= begin
        tests = {}
        parser = RubyParser.new
        sexps = parser.parse(File.read(@file))

        sexps.each_of_type(:iter) do |sexp|
          test_sexp = sexp.sexp_body.first
          if test_sexp[2] == :test
            method_name = "test_#{test_sexp.find_node(:arglist).find_node(:str).sexp_body.first}"
            lines = []
            sexp.each_of_type(:call) do |call|
              lines << call.line
            end
            tests[method_name] = [sexp.line, lines.max]
          end
        end

        sexps.each_of_type(:defn) do |sexp|
          method_name = sexp.sexp_body.first
          if method_name =~ /^test/
            tests[method_name] = [sexp.line, sexp.scope.line]
          end
        end
        tests
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
