module M
  class TestMethod < Struct.new(:name, :start_line, :end_line)
    def self.create(suite_class, test_method)
      method     = suite_class.instance_method(test_method)
      start_line = method.source_location.last
      end_line   = method.source.split("\n").size + start_line - 1

      new(test_method, start_line, end_line)
    end
  end
end
