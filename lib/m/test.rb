module M
  class Test < Struct.new(:name, :start_line, :end_line)
    def self.new_from_object_and_method(suite, test_method)
      method     = suite.method(test_method)
      start_line = method.source_location.last
      end_line   = method.to_source.split("\n").size + start_line - 1

      new(test_method, start_line, end_line)
    end
  end
end
