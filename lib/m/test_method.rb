require_relative "finish_line"  if RUBY_VERSION < "4"

module M
  ### Simple data structure for what a test method contains.
  #
  # Too lazy to make a class for this when it's really just a bag of data
  # without any behavior.
  #
  # Includes the name of this method, what line on the file it begins on,
  # and where it ends.
  TestMethod = Struct.new :name, :start_line, :end_line do
    def self.create suite_class, test_method
      method = suite_class.instance_method test_method

      # Ruby can find the starting line for us, so pull that out of the array.
      # Ruby 4.0+ can also provide the ending line.
      start_line, end_line = method.source_location.values_at(1, 3)

      # Ruby < 4.0 can't find the end line. Use a Ripper-derived parser to
      # determine the ending line.
      end_line ||= FinishLine.ending_line_for method

      # Shove the given attributes into a new databag
      new test_method, start_line, end_line
    end
  end
end
