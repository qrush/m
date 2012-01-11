#`m`  stands for :metal: (metal), which is a better test/unit test runner. @sferik took `t` so this was the next best option.
#[![m ci](https://secure.travis-ci.org/qrush/m.png)](http://travis-ci.org/qrush/m)
#
#![Rush is a heavy metal band. Look it up on Wikipedia.](https://raw.github.com/qrush/m/master/rush.jpg)
#
#<sub>[Rush at the Bristol Colston Hall May 1979](http://www.flickr.com/photos/8507625@N02/3468299995/)</sub>
### Install
#
#Install via:
#
#     gem install m
#
#`m` is Ruby 1.9+ only. Sorry, but `method_source`, `sourcify`, and `ruby_parser` all have trouble with 1.8 so I'm giving up and only supporting 1.9 for now. Patches are welcome!
#
### Usage
#
#Basically, I was sick of using the `-n` flag to grab one test to run. Instead, I prefer how RSpec's test runner allows tests to be run by line number.
#
#Given this file:
#
#     $ cat -n test/example_test.rb
#     1	require 'test/unit'
#     2	
#     3	class ExampleTest < Test::Unit::TestCase
#     4	  def test_apple
#     5	    assert_equal 1, 1
#     6	  end
#     7	
#     8	  def test_banana
#     9	    assert_equal 1, 1
#    10	  end
#    11	end
#
#You can run a test by line number, using format `m TEST_FILE:LINE_NUMBER_OF_TEST`:
#
#     $ m test/example_test.rb:4
#     Run options: -n /test_apple/
#
#     # Running tests:
#
#     .
#
#     Finished tests in 0.000525s, 1904.7619 tests/s, 1904.7619 assertions/s.
#
#     1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
#
#Hit the wrong line number? No problem, `m` helps you out:
#
#     $ m test/example_test.rb:2
#     No tests found on line 2. Valid tests to run:
#
#      test_apple: m test/examples/test_unit_example_test.rb:4
#     test_banana: m test/examples/test_unit_example_test.rb:8
#
#Want to run the whole test? Just leave off the line number.
#
#     $ m test/example_test.rb
#     Run options: 
#
#     # Running tests:
#
#     ..
#
#     Finished tests in 0.001293s, 1546.7904 tests/s, 3093.5808 assertions/s.
#
#     1 tests, 2 assertions, 0 failures, 0 errors, 0 skips
#
#`m` also works with `ActiveSupport::TestCase` as well, so it will work great with your Rails test suites.
#
### License
#
#This gem is MIT licensed, please see `LICENSE` for more information.

#### Stdlib requires
# Using delegators and open structs since I'm too lazy to make objects
require "forwardable"
require "ostruct"

#### External requires
# After trying several source parsing libraries, this is the only one that seems to work consistently.
require "method_source"

#### Internal requires
require "m/runner"
require "m/test_collection"
require "m/test_method"

#### Public interface
# Maybe this gem should have a longer name? Metal?
module M
  VERSION = "0.0.1"

  # Accept arguments coming from bin/m and run tests.
  def self.run(argv)
    Runner.new(argv).run
  end
end
