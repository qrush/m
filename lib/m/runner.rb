module M
  class Runner
    def initialize(argv)
      @file, line = argv.first.split(':')
      @line = line.to_i
    end

    def run
      tests_to_run = tests.within(@line)

      if tests_to_run.size > 0
        test_names = tests_to_run.map(&:name).join('|')
        exit Test::Unit::AutoRunner.run(false, nil, ["-n", "/(#{test_names})/"])
      else
        message = "No tests found on line #{@line}. Valid tests to run:\n\n"
        tests.by_line_number do |test|
          message << "#{sprintf("%0#{tests.column_size}s", test.name)}: m #{@file}:#{test.start_line}\n"
        end
        abort message
      end
    end

    private

    def suites
      $:.unshift "./test"
      load @file
      Test::Unit::TestCase.test_suites.inject({}) do |suites, suite_class|
        suites[suite_class] = suite_class.test_methods unless suite_class.test_methods.empty?
        suites
      end
    end

    def tests
      @tests ||= begin
        collection = TestCollection.new
        suites.each do |suite_class, test_methods|
          test_methods.each do |test_method|
            collection << TestMethod.create(suite_class, test_method)
          end
        end
        collection
      end
    end
  end
end
