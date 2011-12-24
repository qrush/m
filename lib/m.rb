require "ruby_parser"
require 'pp'

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
        parser = RubyParser.new
        sexps = parser.parse(File.read(@file))
        sexps.each_of_type(:defn) do |sexp|
          if @line >= sexp.line && @line <= sexp.scope.line
            run_tests sexp.sexp_body.first
          end
        end
      end
    end

    private

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
