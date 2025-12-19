module M
  class Frameworks
    def self.minitest_version_major
      if defined?(Minitest::Unit::VERSION)
        Minitest::Unit::VERSION.slice(/\d+/)
      elsif defined?(Minitest::VERSION)
        Minitest::VERSION.slice(/\d+/)
      end
    end

    def self.minitest6?
      minitest_version_major == "6"
    end

    def self.minitest5?
      minitest_version_major == "5"
    end

    def self.test_unit?
      defined?(Test::Unit)
    end

    def self.framework_runner
      new.framework_runner
    end

    def framework_runner
      if minitest6?
        Runners::Minitest6.new
      elsif minitest5?
        Runners::Minitest5.new
      elsif test_unit?
        Runners::TestUnit.new
      else
        Runners::UnsupportedFramework.new
      end
    end

    private

    def minitest6?
      self.class.minitest6?
    end

    def minitest5?
      self.class.minitest5?
    end

    def test_unit?
      self.class.test_unit?
    end
  end
end
