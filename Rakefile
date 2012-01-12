#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/clean'
require "rake/testtask"

task :default => [:docs, :test]

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
end

# ROCCO ===============================================================

require 'rdiscount'
require 'rocco/tasks'
Rocco::make 'docs/'

desc 'Build rocco docs'
task :docs => :rocco
directory 'docs/'

desc 'Build docs and open in browser for the reading'
task :read => :docs do
  sh 'open docs/lib/m.html'
end

# Make index.html a copy of rocco.html
file 'docs/index.html' => 'docs/lib/m.html' do |f|
  cp 'docs/lib/m.html', 'docs/index.html', :preserve => true
end

task :docs => 'docs/index.html'
CLEAN.include 'docs/index.html'

# Alias for docs task
task :doc => :docs

# GITHUB PAGES ===============================================================

desc "really kill docs folder"
task :clean_docs do
  sh "rm -rf docs/"
end

desc 'Update gh-pages branch'
task :pages => [:clean_docs, 'docs/.git', :docs] do
  rev = `git rev-parse --short HEAD`.strip
  Dir.chdir 'docs' do
    sh "mv lib/m m"
    sh "mv lib/m.html m/m.html"
    sh "git add -A"
    sh "git commit -m 'rebuild pages from #{rev}'" do |ok,res|
      if ok
        verbose { puts "gh-pages updated" }
        sh "git push -q o HEAD:gh-pages"
      end
    end
  end
end

# Update the pages/ directory clone
file 'docs/.git' => ['docs/'] do |f|
  sh "cd docs && git init -q && git remote add o ../.git" if !File.exist?(f.name)
  sh "cd docs && git fetch -q o && git reset -q --hard o/gh-pages && git rm -r . && git commit -m 'blank out' && touch ."
end
CLOBBER.include 'docs/.git'
