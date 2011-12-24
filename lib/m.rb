require "ruby_parser"

require "m/version"

module M
  class Runner
    def initialize(argv)
      @file, @line = argv.first.split(':')
    end

    def run
      if @line
        parser = RubyParser.new
        sexps = parser.parse(File.read(@file))
        sexps.each_of_type(:defn) do |sexp|
          if sexp.line == @line.to_i
            method_name = sexp.sexp_body.first
            run_tests method_name
          end
        end
      else
        run_tests
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
