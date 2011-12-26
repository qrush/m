require "forwardable"
require "ostruct"

require "ruby_parser"
require "sourcify"

require "m/runner"
require "m/test"
require "m/test_collection"
require "m/version"

module M
  def self.run(argv)
    Runner.new(argv).run
  end
end
