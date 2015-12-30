module M
  class Testable
    attr_accessor :file, :recursive
    attr_reader :line

    def initialize(file = "", line = nil, recursive = false)
      @file = file
      @line = line
      @recursive = recursive
    end

    def line=(line)
      @line ||= line.to_i
    end

    def recursive?
      recursive == true
    end
  end
end
