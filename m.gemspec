Gem::Specification.new do |gem|
  gem.authors       = ["Nick Quaranto"]
  gem.email         = ["nick@quaran.to"]
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "m"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"

  gem.add_runtime_dependency "ruby_parser", "~> 2.3.1"
  gem.add_runtime_dependency "sourcify", "~> 0.5"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "activesupport"

  gem.summary = description = %q{Run test/unit tests by line number. Metal!}
end
