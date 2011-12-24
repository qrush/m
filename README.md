# m

`m` stands :metal: (metal), which is a better test/unit test runner. @sferik took `t` so this was the next best option.

## Usage

Basically, I was sick of using the `-n` flag to grab one test to run, like RSpec's test runner works.

Given this file:

     $ cat -n test/example_test.rb
     1	require 'test/unit'
     2	
     3	class ExampleTest < Test::Unit::TestCase
     4	  def test_apple
     5	    assert_equal 1, 1
     6	  end
     7	
     8	  def test_banana
     9	    assert_equal 1, 1
    10	  end
    11	end

You can run a test by line number, using format `m TEST_FILE:LINE_NUMBER_OF_TEST`:

    $ m test/example_test.rb:4
    Run options: -n /test_apple/

    # Running tests:

    .

    Finished tests in 0.000525s, 1904.7619 tests/s, 1904.7619 assertions/s.

    1 tests, 1 assertions, 0 failures, 0 errors, 0 skips

## License

This gem is MIT licensed, please see `LICENSE` for more information.
