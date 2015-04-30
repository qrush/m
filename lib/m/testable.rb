module M
  class Testable
    attr_accessor :file
    attr_reader :line

    def initialize(file = "", line = nil)
      @file = file
      @line = line
    end

    def line=(line)
      @line ||= line.to_i
    end
  end
end
