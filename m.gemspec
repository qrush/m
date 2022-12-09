require "./lib/m"

Gem::Specification.new do |gem|
  gem.authors = ["Nick Quaranto"]
  gem.email = ["nick@quaran.to"]
  gem.homepage = "https://github.com/qrush/m"

  gem.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files = `git ls-files`.split "\n"
  gem.name = "m"
  gem.require_paths = ["lib"]
  gem.version = M::VERSION

  gem.add_runtime_dependency "method_source", ">= 0.6.7"
  gem.add_runtime_dependency "rake", ">= 0.9.2.2"

  gem.add_development_dependency "activesupport"
  gem.add_development_dependency "appraisal"
  gem.add_development_dependency "rdiscount" unless defined? JRUBY_VERSION
  gem.add_development_dependency "rocco" unless defined? JRUBY_VERSION
  gem.add_development_dependency "standard"

  gem.required_ruby_version = ">= 1.9"

  gem.summary = gem.description = "Run test/unit tests by line number. Metal!"
  gem.metadata["rubygems_mfa_required"] = "true"
end
