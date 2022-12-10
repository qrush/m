require "m/test_parser"

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
      _file, line_range = TestParser.definition_for method
      new test_method, line_range.begin, line_range.end
    end
  end
end
