require_relative "testable"

module M
  class Parser
    def initialize argv
      @argv = argv
      @testable = Testable.new
    end

    def parse
      # With no arguments,
      if argv.empty?
        # Just shell out to `rake test`.
        exec "rake test"
      else
        parse_options! argv

        if argv.first.start_with? "--"
          exec "rake test #{argv.join}"
          exit 0
        else
          # Parse out ARGV, it should be coming in in a format like `test/test_file.rb:9:19`
          parsed = argv.shift.split ":"
          testable.file = parsed.shift
          testable.lines = parsed if testable.lines.none?
          # Anything else on ARGV will be passed along to the runner
          testable.passthrough_options = argv
        end

        # If this file is a directory, not a file, run the tests inside of this directory
        return testable unless Dir.exist? testable.file

        # Make a new rake test task with a hopefully unique name, and run every test looking file in it
        require "rake/testtask"
        Rake::TestTask.new :m_custom do |t|
          t.libs << "test"
          t.libs << "spec"
          t.test_files = FileList[wildcard("test"), wildcard("spec")]
          t.warning = false
        end
        # Invoke the rake task and exit, hopefully it'll work!
        begin
          Rake::Task["m_custom"].invoke
        rescue RuntimeError
          exit 1
        ensure
          exit $?.exitstatus
        end

      end
    end

    private

    attr_reader :argv, :testable

    def parse_options! argv
      require "optparse"

      OptionParser.new do |opts|
        opts.banner = "Options:"
        opts.version = M::VERSION

        opts.on "-h", "--help", "Display this help." do
          puts "Usage: m [OPTIONS] [FILES]\n\n", opts
          exit
        end

        opts.on "--version", "Display the version." do
          puts "m #{M::VERSION}"
          exit
        end

        opts.on "-l", "--line LINE", Integer, "Line number for file." do |line|
          p "parsing line #{line}"
          testable.lines = [line]
        end

        opts.on "-r", "--recursive DIR", "Search provided directory recursively." do |directory|
          testable.recursive = true
          argv << directory
        end

        opts.parse! argv
      end
    end

    def wildcard type
      if testable.recursive
        "#{testable.file}/**/*#{type}*.rb"
      else
        "#{testable.file}/*#{type}*.rb"
      end
    end
  end
end
