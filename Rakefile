#!/usr/bin/env rake
require "rubygems"
require "bundler/setup"
require "appraisal"
require "coveralls"
require "bundler/gem_tasks"
require "rake/clean"
require "rake/testtask"
require "standard/rake"

task default: [:test, :standard]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.pattern = "test/*_test.rb"
end

desc "Run all tests and get merged test coverage"
task :tests do
  system "rake test" or exit! 1
  system "appraisal minitest4 rake test" or exit! 1
  system "appraisal minitest5 rake test TEST=test/minitest_5_test.rb" or exit! 1
  system "appraisal test_unit_gem rake test TEST=test/test_unit_test.rb" or exit! 1
  Coveralls.push!
end

desc "Run simple benchmarks"
task :bench do
  current_commit = `git rev-parse HEAD`
  file_name = "benchmarks/#{Time.now.strftime "%Y%m%d"}-benchmark.log"
  exec "echo -e 'Data for commit: #{current_commit}' > #{file_name} && ruby test/bench.rb >> #{file_name}"
end
