require_relative "../../test/test_helper.rb"

class ErrorTest < MTest
  def test_purposeful_error
    raise RuntimeError
  end
end
