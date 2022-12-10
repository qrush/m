require_relative "../../test/test_helper"

class ErrorTest < MTest
  def test_purposeful_error
    raise RuntimeError
  end
end
