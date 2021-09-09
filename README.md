M.RB

[![Gem Version](https://badge.fury.io/rb/m.svg)](https://rubygems.org/gems/m) [![Code Climate](https://codeclimate.com/github/qrush/m.svg)](https://codeclimate.com/github/qrush/m) [![Build Status](https://travis-ci.org/qrush/m.svg?branch=master)](https://travis-ci.org/qrush/m) [![Coverage Status](https://coveralls.io/repos/qrush/m/badge.svg?branch=master)](https://coveralls.io/r/qrush/m)


----

`m` stands for metal, a better test/unit and minitest test runner that can run tests by line number.

INSTALL
=======

Install via:


    $ gem install m


If you’re using Bundler, you’ll need to include it in your Gemfile. Toss it into the test group:

``` ruby
group :test do
  gem 'm', '~> 1.5.0'
end
```

Developing a RubyGem? Add m as a development dependency.


``` ruby
Gem::Specification.new do |gem|
  # ...
  gem.add_development_dependency "m", "~> 1.5.0"
end
```

m works on Ruby 2.0+ only and support is only provided for [versions currently maintained by the community](https://www.ruby-lang.org/en/downloads/branches/).


USAGE
=====

Basically, I was sick of using the -n flag to grab one test to run. Instead, I prefer how RSpec’s test runner allows tests to be run by line number.

Given this file:


    $ cat -n test/example_test.rb
     1  require 'test/unit'
     2
     3  class ExampleTest < Test::Unit::TestCase
     4    def test_apple
     5      assert_equal 1, 1
     6    end
     7
     8    def test_banana
     9      assert_equal 1, 1
    10    end
    11  end


You can run a test by line number, using format m TEST_FILE:LINE_NUMBER_OF_TEST:


    $ m test/example_test.rb:4
    Run options: -n /test_apple/

    # Running tests:

    .

    Finished tests in 0.000525s, 1904.7619 tests/s, 1904.7619 assertions/s.

    1 tests, 1 assertions, 0 failures, 0 errors, 0 skips


Hit the wrong line number? No problem, m helps you out:


    $ m test/example_test.rb:2
    No tests found on line 2. Valid tests to run:

     test_apple: m test/examples/test_unit_example_test.rb:4
    test_banana: m test/examples/test_unit_example_test.rb:8


Want to run the whole test? Just leave off the line number.


    $ m test/example_test.rb
    Run options:

    # Running tests:

    ..

    Finished tests in 0.001293s, 1546.7904 tests/s, 3093.5808 assertions/s.

    1 tests, 2 assertions, 0 failures, 0 errors, 0 skips

If you want to run all the tests in a directory as well as its subdirectories, use the `-r` flag:

    $ m -r test/models
    "Searching provided directory for tests recursively"
    Run options:

    ..

    Finished in 3.459902s, 45.0880 runs/s, 87.5747 assertions/s.

    156 tests, 303 assertions, 0 failures, 0 errors, 13 skips

If you need to pass some option down to the actual runner, that is also supported:

    $ m test/models -- --seed 1234
    Run options: --seed 1234

    ..

    Finished in 3.459902s, 45.0880 runs/s, 87.5747 assertions/s.

    156 tests, 303 assertions, 0 failures, 0 errors, 13 skips

Ensure that you use the `--` before the options, otherwise you'll get an invalid option error. Also, these extra option should always be the last argument.


SUPPORT
=======

`m` works with a few Ruby test frameworks:

  - Test::Unit
  - ActiveSupport::TestCase
  - MiniTest::Unit::TestCase
  - Minitest


CONTRIBUTING
============

## Setup

This project uses [Appraisal](https://github.com/thoughtbot/appraisal) to test against different versions of dependencies.

To install all scenarios (appraisals):

    bundle install
    bundle exec appraisal install

## Testing

You can run all the tests with:

    bundle exec rake tests

You can also run tests selectively. For minitest 4 run:

    appraisal minitest4 rake test

and the ones for minitest 5 with:

    appraisal minitest5 rake test


LICENSE
=======

This gem is MIT licensed, please see LICENSE for more information.
