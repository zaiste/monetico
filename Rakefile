# encoding: utf-8

#!/usr/bin/env rake
#require "bundler/gem_tasks"

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

#require 'jeweler'
#Jeweler::Tasks.new do |gem|
#  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
#  gem.name = "gem name"
#  gem.homepage = "http://github.com/zaiste/monetico"
#  gem.license = "licence"
#  gem.summary = %Q{summary}
#  gem.description = %Q{desc}
#  gem.email = "..."
#  gem.authors = ["..."]
#  # dependencies defined in Gemfile
#
#  gem.files = FileList[
#    "[A-Z]*", "{bin,generators,lib,test}/**/*"
#  ]
#end
#Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "simple_metar_parser #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
