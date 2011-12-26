module M
  class TestCollection
    include Enumerable

    def initialize
      @collection = []
    end

    def <<(test)
      @collection << test
    end

    def each(&block)
      @collection.each(&block)
    end
  end
end
