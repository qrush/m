require 'test_helper'

class LoadPathsTest < MTest
  def test_run_file_with_code_on_different_path
    output = m('-I./examples/load_paths examples/load_paths/meme_test.rb')
    assert $?.success?
    assert_output(/3 tests/, output)
  end

  def test_run_directory_with_code_on_different_path
    output = m('-I./examples/load_paths examples/load_paths/')
    assert $?.success?
    assert_output(/3 tests/, output)
  end
end
