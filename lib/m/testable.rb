module M
  class Testable
    attr_accessor :file, :recursive, :libs
    attr_reader :line

    def initialize(file = "", line = nil, recursive = false)
      @file = file
      @line = line
      @recursive = recursive
      @libs = []
    end

    def line=(line)
      @line ||= line.to_i
    end
  end
end
