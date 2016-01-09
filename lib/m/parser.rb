require_relative 'testable'

module M
  class Parser
    def initialize(argv)
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

        # Parse out ARGV, it should be coming in in a format like `test/test_file.rb:9`
        testable.file, testable.line = argv.first.split(':')

        # If this file is a directory, not a file, run the tests inside of this directory
        if Dir.exist?(testable.file)
          # Make a new rake test task with a hopefully unique name, and run every test looking file in it
          require "rake/testtask"
          Rake::TestTask.new(:m_custom) do |t|
            t.libs << 'test'
            t.libs << 'spec'
            t.test_files = FileList[wildcard("test"), wildcard("spec")]
          end
          # Invoke the rake task and exit, hopefully it'll work!
          begin
            Rake::Task['m_custom'].invoke
          rescue RuntimeError
            exit
          ensure
            exit
          end
        else
          return testable
        end
      end
    end

    private

    attr_reader :argv, :testable

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
          p "parsing line #{line}"
          testable.line = line
        end

        opts.on '-r', 'Search provided directory recursively.' do |line|
          testable.recursive = true
        end

        opts.parse! argv
      end
    end

    def wildcard(type)
      if testable.recursive
        "#{testable.file}/**/*#{type}*.rb"
      else
        "#{testable.file}/*#{type}*.rb"
      end
    end
  end
end
