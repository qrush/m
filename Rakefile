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

desc "Run all tests and get merged test coverage"
namespace :test do
  Dir.glob("gemfiles/*.gemfile").each do |gemfile_path|
    name = /gemfiles\/(.*).gemfile/.match(gemfile_path)[1]
    desc "Run #{name} tests"
    task name do |rake_task|
      gemfile_name = rake_task.name.split(":").last
      gemfile_path = "gemfiles/#{gemfile_name}.gemfile"
      Bundler.with_original_env do
        sh "BUNDLE_GEMFILE=#{gemfile_path} bundle exec #{RbConfig.ruby} -S rake"
      end
    end
  end
end

desc "Run all tests and get merged test coverage"
task :tests do
  Dir.glob("gemfiles/*.gemfile").each do |gemfile_path|
    Bundler.with_original_env do
      sh "BUNDLE_GEMFILE=#{gemfile_path} bundle exec #{RbConfig.ruby} -S rake"
    end
  end
  Coveralls.push!
end

desc "Run simple benchmarks"
task :bench do
  current_commit = `git rev-parse HEAD`
  file_name = "benchmarks/#{Time.now.strftime "%Y%m%d"}-benchmark.log"
  exec "echo -e 'Data for commit: #{current_commit}' > #{file_name} && #{RbConfig.ruby} test/bench.rb >> #{file_name}"
end
