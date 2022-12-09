module M
  class Testable
    attr_accessor :file, :recursive, :passthrough_options
    attr_reader :lines

    def initialize file = "", lines = [], recursive = false
      @file = file
      @recursive = recursive
      @passthrough_options = []
      self.lines = lines
    end

    def lines= lines
      @lines = lines.map(&:to_i)
    end
  end
end
