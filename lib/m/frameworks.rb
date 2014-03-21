module M
  class Frameworks
    def self.minitest5?
      defined?(Minitest) && Minitest::Unit::VERSION.start_with?("5")
    end

    def self.minitest4?
      defined?(MiniTest)
    end
  end
end
