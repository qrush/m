module M
  class TestCollection
    include Enumerable
    extend Forwardable
    def_delegators :@collection, :size, :<<, :each

    def initialize(collection = nil)
      @collection = collection || []
    end

    def within(line)
      self.class.new(select do |test|
        (test.start_line..test.end_line).include? line
      end)
    end
  end
end
