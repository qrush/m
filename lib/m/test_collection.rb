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
        line.zero? || (test.start_line..test.end_line).include?(line)
      end)
    end

    def column_size
      @column_size ||= map { |test| test.name.to_s.size }.max
    end

    def by_line_number(&block)
      sort_by(&:start_line).each(&block)
    end
  end
end
