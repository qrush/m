#!/usr/bin/env rake
require "rubygems"
require "bundler/setup"
require "coveralls"
require "bundler/gem_tasks"
require "rake/clean"
require "rake/testtask"
require "standard/rake"
require "rbconfig"

task default: [:test, "standard:fix"]

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

desc "Run simple benchmarks"
task :bench do
  current_commit = `git rev-parse HEAD`
  file_name = "benchmarks/#{Time.now.strftime "%Y%m%d"}-benchmark.log"
  exec "echo -e 'Data for commit: #{current_commit}' > #{file_name} && #{RbConfig.ruby} test/bench.rb >> #{file_name}"
end
