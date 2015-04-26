### M, your metal test runner
# Maybe this gem should have a longer name? Metal?
require_relative 'version'
require_relative 'm/frameworks'
require_relative 'm/runners/base'

module M
  # Accept arguments coming from bin/m and run tests, then bail out immediately.
  def self.run(argv)
    # sync output since we're going to exit hard and fast
    $stdout.sync = true
    $stderr.sync = true
    exit! Runners::Base.new(argv).run
  end
end
