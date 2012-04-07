require './lib/m'

Gem::Specification.new do |gem|
  gem.authors       = ["Nick Quaranto"]
  gem.email         = ["nick@quaran.to"]
  gem.homepage      = "https://github.com/qrush/m"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "m"
  gem.require_paths = ["lib"]
  gem.version       = M::VERSION

  gem.add_runtime_dependency "method_source", "~> 0.6.7"
  gem.add_runtime_dependency "rake", ">= 0.9.2.2", "< 1.0.0"
  gem.add_development_dependency "activesupport"
  gem.add_development_dependency "rdiscount"
  gem.add_development_dependency "rocco"
  gem.add_development_dependency "minitest"

  gem.required_ruby_version = "~> 1.9"

  gem.summary = description = %q{Run test/unit tests by line number. Metal!}
end
