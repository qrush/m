module M
  class Frameworks
    def self.framework_runner
      new.framework_runner
    end

    def framework_runner
      if minitest5?
        Runners::Minitest5.new
      elsif minitest4?
        Runners::Minitest4.new
      elsif test_unit?
        Runners::TestUnit.new
      else
        Runners::UnsupportedFramework.new
      end
    end

    private

    def minitest5?
      self.class.minitest5?
    end

    def minitest4?
      self.class.minitest4?
    end

    def test_unit?
      self.class.test_unit?
    end

    def self.minitest5?
      defined?(Minitest) && Minitest::Unit::VERSION.start_with?("5")
    end

    def self.minitest4?
      defined?(MiniTest)
    end

    def self.test_unit?
      defined?(Test::Unit)
    end
  end
end
